{...}: {
  services.vaultwarden = {
    enable = true;
    dbBackend = "sqlite";
    config = {
      domain = "https://bitwarden.hpcesia.com";
      signupsAllowed = false;
      rocketAddress = "127.0.0.1";
      rocketPort = 40031;
      webVaultEnabled = true;
    };
  };
}
