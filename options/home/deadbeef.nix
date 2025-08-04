{
  lib,
  config,
  pkgs,
  ...
}: let
  inherit (lib) mkOption types;
  cfg = config.programs.deadbeef;

  keyValueFormat = pkgs.formats.keyValue {};
  JSONFormat = pkgs.formats.json {};

  embededJSONType = types.submodule {freeformType = JSONFormat.type;};
in {
  options.programs.deadbeef = {
    enable = lib.mkEnableOption "Enable DeaDBeeF";
    package = lib.mkPackageOption pkgs "deadbeef-with-plugins" {};
    plugins = mkOption {
      type = types.listOf types.package;
      default = [];
      example = lib.literalExpression ''
        with pkgs.deadbeefPlugins; [
          mpris2
        ];
      '';
    };
    settings = mkOption {
      default = {};
      example = lib.literalExpression ''
        {
          "gtkui.start_hidden" = 1;
          "hotkey.key1" = "\"space\" 0 0 toggle_pause";
        }
      '';
      type = types.submodule {
        freeformType = keyValueFormat.type;
        options = {
          gtkui.layout = mkOption {
            default = {};
            description = ''
              This option will generate a JSON string into "gtkui.layout.1.9.0" key.
            '';
            type = embededJSONType;
          };
          gtkui.columns.playlist = mkOption {
            default = [];
            description = ''
              This option will generate a JSON string into "gtkui.columns.playlist" key.
            '';
            type = types.listOf embededJSONType;
          };
          gtkui.columns.search = mkOption {
            default = [];
            description = ''
              This option will generate a JSON string into "gtkui.columns.search" key.
            '';
            type = types.listOf embededJSONType;
          };
        };
      };
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [(cfg.package.override {plugins = cfg.plugins;})];
    systemd.user.services.merge-deadbeef-config = let
      deadbeefProcessedConfig =
        {
          "gtkui.layout.1.9.0" = builtins.toJSON cfg.settings.gtkui.layout;
          "gtkui.columns.playlist" = builtins.toJSON cfg.settings.gtkui.columns.playlist;
          "gtkui.columns.search" = builtins.toJSON cfg.settings.gtkui.columns.search;
        }
        // (lib.removeAttrs cfg.settings ["gtkui"]);
      deadbeefConfig = with lib.generators;
        toKeyValue {mkKeyValue = mkKeyValueDefault {} " ";} deadbeefProcessedConfig;
    in {
      Unit = {
        Description = "Merge Nix-managed DeaDBeeF configuration";
        After = ["graphical-session-pre.target"];
        PartOf = ["graphical-session.target"];
      };
      Service = {
        Type = "oneshot";
        ExecStart = lib.getExe (pkgs.writeShellScriptBin "merge-deadbeef-config" ''
          #!${pkgs.runtimeShell}
          set -eu

          MANAGED_CONFIG_FILE="${pkgs.writeText "deadbeef-managed-config" deadbeefConfig}"

          TARGET_CONFIG_FILE="$HOME/.config/deadbeef/config"
          mkdir -p "$(dirname "$TARGET_CONFIG_FILE")"
          touch "$TARGET_CONFIG_FILE"

          ${pkgs.gawk}/bin/awk '
            NR==FNR { a[$1]=$0; next }
            {
              if ($1 in a) {
                print a[$1]
                delete a[$1]
              } else {
                print $0
              }
            }
            END {
              for (k in a) {
                print a[k]
              }
            }
          ' "$MANAGED_CONFIG_FILE" "$TARGET_CONFIG_FILE" > "$TARGET_CONFIG_FILE.tmp" && \
          mv "$TARGET_CONFIG_FILE.tmp" "$TARGET_CONFIG_FILE"
          echo "DeaDBeeF config merged successfully."
        '');
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };
  };
}
