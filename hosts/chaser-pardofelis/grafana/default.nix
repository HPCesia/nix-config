{
  myvars,
  config,
  ...
}: {
  services.grafana = {
    enable = true;
    # See https://grafana.com/docs/grafana/latest/setup-grafana/configure-grafana/#configuration-options
    settings = {
      server = {
        http_addr = "127.0.0.1";
        http_port = 3982;
        protocol = "http";
        domain = "grafana.hpcesia.com";
        serve_from_sub_path = false;
        root_url = "%(protocol)s://%(domain)s:%(http_port)s/";
        read_timeout = "180s";
        enable_gzip = true;
      };
      security = {
        admin_user = myvars.username;
        admin_email = myvars.useremail;
        admin_password = "$__file{${config.sops.secrets."grafana-admin-password".path}}";
      };
      users = {
        allow_sign_up = false;
        default_theme = "dark";
        default_language = "detect";
      };
    };
  };
}
