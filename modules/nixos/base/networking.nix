{
  config,
  lib,
  hostName,
  ...
}:
lib.mkMerge [
  {
    # Use an NTP server located in the mainland of China to synchronize the system time
    networking.timeServers = [
      "ntp.aliyun.com" # Aliyun NTP Server
      "ntp.tencent.com" # Tencent NTP Server
    ];
  }

  (let
    cfg = config.modules.my-hosts.${hostName}.network;
  in
    lib.mkIf cfg.useDHCP {
      assertions = map (x: {
        assertion = cfg.${x} == null;
        message = "my-host.network.useDHCP is confilt with my-host.network.${x}";
      }) ["ipv4" "ipv6"];
    })

  (let
    cfg = config.modules.my-hosts.${hostName}.network;
  in
    lib.mkIf
    (cfg.enable == "networkmanager")
    {
      networking = with cfg; {
        networkmanager.enable = true;
        useDHCP = lib.mkDefault useDHCP;
        inherit hostName search defaultGateway defaultGateway6 nameservers;
        interfaces.${cfg.iface} = lib.mkIf (!builtins.isNull cfg.ipv4 && !builtins.isNull cfg.ipv6) {
          ipv4.addresses = lib.optional (!builtins.isNull cfg.ipv4) {
            address = cfg.ipv4;
            prefixLength = cfg.prefixLength4;
          };
          ipv6.addresses = lib.optional (!builtins.isNull cfg.ipv6) {
            address = cfg.ipv6;
            prefixLength = cfg.prefixLength6;
          };
        };
      };
    })
  (let
    cfg = config.modules.my-hosts.${hostName}.network;
  in
    lib.mkIf
    (cfg.enable == "networkd")
    {
      networking.useNetworkd = true;
      networking.hostName = hostName;
      systemd.network.networks."10-${cfg.iface}" = {
        matchConfig.Name = [cfg.iface];
        networkConfig = {
          Address =
            (lib.optionals (!builtins.isNull cfg.ipv4) ["${cfg.ipv4}/${toString cfg.prefixLength4}"])
            ++ (lib.optionals (!builtins.isNull cfg.ipv6) ["${cfg.ipv6}/${toString cfg.prefixLength6}"]);
          DNS = cfg.nameservers;
        };
        routes =
          (lib.optional (!builtins.isNull cfg.defaultGateway)
            {
              Destination = "0.0.0.0/0";
              Gateway = cfg.defaultGateway;
            })
          ++ (lib.optional (!builtins.isNull cfg.defaultGateway6) {
            Destination = "::/0";
            Gateway = cfg.defaultGateway6;
          });
        linkConfig.RequiredForOnline = "routable";
      };
    })
]
