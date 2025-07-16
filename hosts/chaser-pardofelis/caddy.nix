{myvars, ...}: {
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
    };
  };

  networking.firewall.allowedTCPPorts = [80 443];
}
