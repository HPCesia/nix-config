{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [./config];
  config = lib.mkIf config.services.mihomo.enable {
    services.mihomo = {
      tunMode = true;
      webui = pkgs.metacubexd;
    };
  };
}
