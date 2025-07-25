{pkgs-unstable, ...}: {
  # Atuin server for shell history sync
  services.atuin = {
    enable = true;
    package = pkgs-unstable.atuin;
    host = "127.0.0.1";
    port = 10423;
    openRegistration = false;
    database.createLocally = false; # Disable create PostgreSQL
    database.uri = "sqlite:///var/lib/atuin/atuin.db";
  };

  systemd.services.atuin = {
    serviceConfig = {
      StateDirectory = "atuin";
      StateDirectoryMode = "0700";
    };
  };
}
