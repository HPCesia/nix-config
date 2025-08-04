{...}: {
  services.mihomo.config.dns = {
    enable = true;
    prefer-h3 = true;
    ipv6 = false;
    enhanced-mode = "fake-ip";
    fake-ip-range = "198.18.0.1/16";
    fake-ip-filter = [
      "+.+m2m"
      "+.$injections.adguard.org"
      "+.$local.adguard.org"
      "+.+bogon"
      "+.+lan"
      "+.+local"
      "+.+localdomain"
      "+.home.arpa"
      "dns.msftncsi.com"
      "*.srv.nintendo.net"
      "*.stun.playstation.net"
      "xbox.*.microsoft.com"
      "*.xboxlive.com"
      "*.turn.twilio.com"
      "*.stun.twilio.com"
      "stun.syncthing.net"
      "stun.*"
      "*.sslip.io"
      "*.nip.io"
    ];
    respect-rules = true;
    nameserver = [
      "system"
      "https://223.5.5.5/dns-query"
      "https://doh.pub/dns-query"
    ];
    proxy-server-nameserver = [
      "https://223.5.5.5/dns-query"
      "https://doh.pub/dns-query"
    ];
  };
}
