{
  mylib,
  myvars,
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.lists) concatLists;

  homeDir = config.home.homeDirectory;
  userDataDir = "${homeDir}/.data/vscode/data";
  extensionsDir = "${homeDir}/.data/vscode/extensions";

  pkg = pkgs.vscode.override {
    commandLineArgs = concatLists [
      ["--extensions-dir" extensionsDir]
      ["--user-data-dir" userDataDir]
    ];
  };
in {
  imports = [./profiles];

  programs.vscode = {
    enable = true;
    package = pkg;
    mutableExtensionsDir = false;
  };

  catppuccin.vscode.enable = true;

  # To solve VSCode wants to write settings.json
  # VSCode will reset per reboot/rebuild.
  systemd.user.services.vscode-setup = {
    Unit = {
      Description = "VSCode Setup service";
      After = ["graphical-session-pre.target"];
      Wants = ["graphical-session-pre.target"];
    };
    Install.WantedBy = ["graphical-session.target"];
    Service = {
      Type = "oneshot";
      ExecStart = lib.getExe (pkgs.writeShellApplication {
        name = "vscode-setup";
        text = ''
          rm -rf "${userDataDir}/User"
          rm -rf "${extensionsDir}"

          mkdir -p "${userDataDir}"
          mkdir -p "${extensionsDir}"

          cp -r --dereference --no-preserve=mode,ownership \
            "${homeDir}/.config/Code/User" "${userDataDir}/User"
          cp -r --dereference --no-preserve=mode,ownership \
            "${homeDir}/.vscode/extensions/." "${extensionsDir}"
        '';
      });
    };
  };
}
