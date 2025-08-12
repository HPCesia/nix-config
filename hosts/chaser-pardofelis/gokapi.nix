{
  lib,
  config,
  myvars,
  ...
}: {
  services.gokapi = {
    enable = true;
    mutableSettings = true;
    environment = {
      GOKAPI_PORT = 53842;
      GOKAPI_ADMIN_USER = myvars.useremail;
    };
    settings = {
      ServerUrl = "https://send.hpcesia.com/";
      RedirectUrl = "https://github.com/Forceu/Gokapi/";
      PublicName = "Tribios";
      DatabaseUrl = "sqlite:///var/lib/gokapi/data/db.sqlite";
      UseSsl = false;
      SaveIp = false;
      IncludeFilename = true;
      MaxFileSizeMB = 2048;
      MaxMemory = 50;
      ChunkSize = 45;
      MaxParallelUploads = 4;
      PicturesAlwaysLocal = false;
      Encryption = {
        Level = 0;
        Cipher = null;
      };
      Authentication = {
        Method = 1;
        Username = "HPCesia";
        OauthProvider = "https://authelia.hpcesia.com";
        OAuthClientId = "gokapi";
        OAuthRecheckInterval = 12;
      };
    };
    settingsFile = config.sops.templates.gokapi-config.path;
  };

  systemd.services.gokapi.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "gokapi";
    Group = "gokapi";
  };

  sops.templates.gokapi-config = {
    content = builtins.toJSON {
      Authentication = {
        SaltAdmin = config.sops.placeholder.gokapi-salt-admin;
        SaltFiles = config.sops.placeholder.gokapi-salt-files;
        OAuthClientSecret = config.sops.placeholder.gokapi-oauth-secret;
      };
    };
    owner = "root";
    group = "gokapi";
    mode = "0440";
  };

  users.users.gokapi = {
    isSystemUser = true;
    useDefaultShell = true;
    group = "gokapi";
  };
  users.groups.gokapi = {};
}
