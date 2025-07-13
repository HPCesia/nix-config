{lib}: let
  defaultNameservers = [
    # IPv4
    "119.29.29.29" # DNSPod
    "223.5.5.5" # AliDNS
    # IPv6
    "2400:3200::1" # Alidns
    "2606:4700:4700::1111" # Cloudflare
  ];
in rec {
  hosts = {
    kevin = {
      environment = {
        nameservers = defaultNameservers;
      };
      useNetworkManager = true;
      iface = "wlp0s20f3";
    };
  };

  generateHostNetworking = hostName: let
    hostData = hosts.${hostName};
    env = hostData.environment;
  in {
    inherit (env) nameservers;
    defaultGateway = lib.mkIf (env ? "defaultGateway6") env.defaultGateway;
    defaultGateway6 = lib.mkIf (env ? "defaultGateway6") env.defaultGateway6;
    search = lib.mkIf (env ? "search") env.search;

    useNetworkd = lib.mkDefault (hostData.useNetworkd or false);
    networkmanager.enable = lib.mkDefault (hostData.useNetworkManager or false);
    useDHCP = lib.mkDefault (hostData.useNetworkManager or false);

    interfaces."${hostData.iface}" = {
      ipv4.addresses = lib.mkIf (hostData ? "ipv4" && hostData.useNetworkd or false) [
        {
          address = hostData.ipv4;
          prefixLength = env.prefixLength or env.prefixLength4;
        }
      ];
      ipv6.addresses = lib.mkIf (hostData ? "ipv6" && hostData.useNetworkd or false) [
        {
          address = hostData.ipv6;
          prefixLength = env.prefixLength6;
        }
      ];
    };
  };

  ssh = {
    extraConfig = let
      sshTargetHosts = lib.attrsets.filterAttrs (name: value: value ? "ipv4") hosts;
    in
      lib.attrsets.foldlAttrs
      (acc: host: val:
        acc
        + ''
          Host ${host}
            HostName ${val.ipv4}
            Port ${val.port or "22"}
        '')
      ""
      sshTargetHosts;
    knownHosts =
      lib.attrsets.mapAttrs'
      (
        host: value:
          lib.attrsets.nameValuePair
          (value.ipv4)
          {
            inherit (value) publicKey;
            hostNames = [host];
          }
      )
      (
        lib.attrsets.filterAttrs (n: v: v ? "publicKey") hosts
      );
  };
}
