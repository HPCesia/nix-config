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

    virtualHosts = let
      localAddress = {
        artalk = "http://localhost:${builtins.toString config.services.artalk.settings.port}";
        authelia = "http://${
          # Assuming address start with `tcp://`.
          builtins.substring 6 (-1) config.services.authelia.instances.main.settings.server.address
        }";
        vaultwarden = "http://localhost:${builtins.toString config.services.vaultwarden.config.rocketPort}";
        gotosocial = "http://localhost:${builtins.toString config.services.gotosocial.settings.port}";
        grafana = "http://localhost:${builtins.toString config.services.grafana.settings.server.http_port}";
        homepage = "http://localhost:${builtins.toString config.services.homepage-dashboard.listenPort}";
        prometheus = "http://${config.services.victoriametrics.listenAddress}";
      };
    in {
      "artalk.hpcesia.com".extraConfig = ''
        encode zstd gzip
        reverse_proxy ${localAddress.artalk}
      '';
      "authelia.hpcesia.com".extraConfig = ''
        encode zstd gzip
        reverse_proxy ${localAddress.authelia}
      '';
      "bitwarden.hpcesia.com".extraConfig = ''
        encode zstd gzip
        reverse_proxy ${localAddress.vaultwarden}
      '';
      "grafana.hpcesia.com".extraConfig = ''
        encode zstd gzip
        reverse_proxy ${localAddress.grafana}
      '';
      "home.hpcesia.com".extraConfig = ''
        encode zstd gzip
        forward_auth ${localAddress.authelia} {
          uri /api/authz/forward-auth
          copy_headers Remote-User Remote-Groups Remote-Email Remote-Name
        }
        reverse_proxy ${localAddress.homepage}
      '';
      "prometheus.hpcesia.com".extraConfig = ''
        encode zstd gzip
        reverse_proxy ${localAddress.prometheus}
      '';
      "trin.one".extraConfig = ''
        encode zstd gzip
        reverse_proxy ${localAddress.gotosocial}
      '';
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
