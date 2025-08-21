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
        SSH_PORT = 2233;
        ROOT_URL = "https://${config.services.forgejo.settings.server.DOMAIN}/";
      };
      service = {
        DISABLE_REGISTRATION = true;
        ENABLE_NOTIFY_MAIL = true;
        ENABLE_BASIC_AUTHENTICATION = false;
      };
      repository = {
        DEFAULT_REPO_UNITS = "repo.code,repo.releases";
      };
      mailer = {
        ENABLED = true;
        PROTOCOL = "smtps";
        SMTP_ADDR = "glacier.mxrouting.net";
        SMTP_PORT = 465;
        USER = "info@hpcesia.com";
        FROM = "Forgejo Infomation <info@hpcesia.com>";
        SUBJECT_PREFIX = "[repo.hpcesia.com] ";
      };
      # TODO: Enable federation after I finalize a suitable instance name and switch to an independent domain.
      federation.ENABLED = false;
      session.COOKIE_SECURE = true;
      log = {
        LEVEL = "Info";
        ENABLE_SSH_LOG = true; # Enable ssh log for fail2ban.
        "logger.router.MODE" = "Error";
      };
      actions = {
        ENABLED = true;
      };
    };
    secrets = {
      mailer.PASSWD = config.sops.secrets.forgejo-mailer-password.path;
    };
  };

  users.users."git" = {
    isSystemUser = true;
    useDefaultShell = true;
    group = config.services.forgejo.group;
    home = config.services.forgejo.stateDir;
    extraGroups = [
      "ssh-secrets-users" # to use ssh-config
    ];
  };

  networking.firewall.allowedTCPPorts = [
    config.services.forgejo.settings.server.SSH_PORT
  ];

  services.fail2ban.jails.forgejo-ssh = {
    settings = {
      filter = "forgejo-ssh";
      action = "iptables-allports";
      mode = "aggressive";
      maxretry = 3;
      findtime = 3600;
      bantime = 900;
    };
  };

  environment.etc."fail2ban/filter.d/forgejo-ssh.conf".text = ''
    [Definition]
    failregex = ^.*(Failed authentication attempt|invalid credentials|Attempted access of unknown user).* from <HOST>$
    journalmatch = _SYSTEMD_UNIT=forgejo.service
  '';
}
