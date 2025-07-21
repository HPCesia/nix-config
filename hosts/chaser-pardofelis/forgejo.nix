{
  pkgs-unstable,
  config,
  ...
}: {
  services.forgejo = {
    enable = true;
    package = pkgs-unstable.forgejo;
    user = "git";
    group = "forgejo";
    database = {
      type = "sqlite3";
    };
    settings = {
      default = {
        APP_NAME = "Forgejo"; # TODO: A new name for my forgejo instance.
        APP_SLOGAN = "Beyond coding. We Forge."; # TODO: A new slogan.
      };
      server = {
        DOMAIN = "repo.hpcesia.com";
        HTTP_ADDR = "127.0.0.1";
        HTTP_PORT = 3125;
        PROTOCOL = "http";
        START_SSH_SERVER = true;
        SSH_PORT = 2222;
        ROOT_URL = "https://${config.services.forgejo.settings.server.DOMAIN}/";
      };
      # TODO: Enable federation after I finalize a suitable instance name and switch to an independent domain.
      federation.ENABLED = false;
      session.COOKIE_SECURE = true;
      log = {
        LEVEL = "Info";
        ENABLE_SSH_LOG = true; # Enable ssh log for fail2ban.
        "logger.router.MODE" = "Error";
      };
    };
  };

  users.users."git" = {
    isSystemUser = true;
    useDefaultShell = true;
    group = config.services.forgejo.group;
    home = config.services.forgejo.stateDir;
  };

  networking.firewall.allowedTCPPorts = [
    config.services.forgejo.settings.server.SSH_PORT
  ];
}
