{
  lib,
  pkgs,
  config,
  helix-steel,
  ...
}: let
  inherit (lib) mkOption types;

  cfg = config.programs.helix.steelEventSystem;
in {
  options.programs.helix.steelEventSystem = {
    enable = lib.mkEnableOption "Enable Helix Steel event system.";
    steelPackage = lib.mkPackageOption pkgs "steel" {};
    initScm = mkOption {
      type = types.either types.lines types.path;
      default = "";
    };
    helixScm = mkOption {
      type = types.either types.lines types.path;
      default = "";
    };
  };

  config = lib.mkIf cfg.enable {
    home.packages = [cfg.steelPackage];
    programs.helix.package = lib.mkDefault helix-steel.packages.${pkgs.system}.default;

    xdg.configFile."helix/init.scm" = let
      scm = cfg.initScm;
    in
      lib.mkIf (lib.stringLength scm != 0) {
        source = lib.mkIf (lib.isPath scm) scm;
        text = lib.mkIf (!(lib.isPath scm)) scm;
      };
    xdg.configFile."helix/helix.scm" = let
      scm = cfg.helixScm;
    in
      lib.mkIf (lib.stringLength scm != 0) {
        source = lib.mkIf (lib.isPath scm) scm;
        text = lib.mkIf (!(lib.isPath scm)) scm;
      };
  };
}
