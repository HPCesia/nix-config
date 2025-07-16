{...}: {
  networking.firewall.enable = true;

  services.fail2ban = {
    enable = true;
    maxretry = 3;
    bantime = "10m";
    bantime-increment.enable = true;
    ignoreIP = [
      "172.16.0.0/12"
      "192.168.0.0/16"
    ];
  };
}
