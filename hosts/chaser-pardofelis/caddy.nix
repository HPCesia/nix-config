{
  myvars,
  config,
  ...
}: {
  services.caddy = {
    enable = true;
    # Reload Caddy instead of restarting it when configuration file changes.
    enableReload = true;

    globalConfig = ''
      http_port   80
      https_port  443
      email ${myvars.useremail}
    '';

    virtualHosts = {
      "grafana.hpcesia.com".extraConfig = ''
        encode zstd gzip
        reverse_proxy http://localhost:${builtins.toString config.services.grafana.settings.server.http_port}
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
