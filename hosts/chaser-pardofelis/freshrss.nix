{
  myvars,
  config,
  ...
}: {
  services.freshrss = {
    enable = true;
    baseUrl = "https://rss.hpcesia.com";
    webserver = "caddy";
    virtualHost = "rss.hpcesia.com";
    authType = "form";
    defaultUser = "admin";
    passwordFile = config.sops.secrets."freshrss-admin-password".path;
    language = "zh-cn";
    database.type = "sqlite";
  };
}
