{pkgs, ...}: let
  port = 5600;
in {
  services.activitywatch = {
    enable = true;
    package = pkgs.aw-server-rust;
    settings = {
      inherit port;
    };
    watchers = {
      awatcher = {
        package = pkgs.awatcher;
        settings = {
          server.port = port;
        };
      };
    };
  };
}
