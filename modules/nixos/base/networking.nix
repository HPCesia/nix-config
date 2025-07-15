{
  config,
  lib,
  ...
}: let
  hostName = config.modules.currentHost;
in
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
        assertions = map (x: {
          assertion = !(cfg.${x} ? "secretName");
          message = "my-host.network.${x} should not be a secret when using networkmanager.";
        }) ["ipv4" "ipv6" "defaultGateway" "defaultGateway6"];
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
      isSecret = v: lib.isAttrs v && v ? "secretName";
      isInEval = x: (!builtins.isNull x && !isSecret x);
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
              (lib.optionals (isInEval cfg.ipv4)
                ["${cfg.ipv4}/${toString cfg.prefixLength4}"])
              ++ (lib.optionals (isInEval cfg.ipv6)
                ["${cfg.ipv6}/${toString cfg.prefixLength6}"]);
            DNS = cfg.nameservers;
          };
          routes =
            (lib.optional (isInEval cfg.defaultGateway)
              {
                Destination = "0.0.0.0/0";
                Gateway = cfg.defaultGateway;
              })
            ++ (lib.optional (isInEval cfg.defaultGateway6) {
              Destination = "::/0";
              Gateway = cfg.defaultGateway6;
            });
          linkConfig.RequiredForOnline = "routable";
        };

        environment.etc."systemd/network/10-${cfg.iface}.network.d/99-address.conf" =
          lib.mkIf
          (isSecret cfg.ipv4 || isSecret cfg.ipv6)
          {
            source = config.sops.templates.networkd-address.path;
            user = "root";
            group = "systemd-network";
            mode = "0440";
          };
        environment.etc."systemd/network/10-${cfg.iface}.network.d/99-route.conf" =
          lib.mkIf
          (isSecret cfg.defaultGateway || isSecret cfg.defaultGateway6)
          {
            source = config.sops.templates.networkd-route.path;
            user = "root";
            group = "systemd-network";
            mode = "0440";
          };

        sops.templates.networkd-address = {
          content =
            lib.mkIf
            (isSecret cfg.ipv4 || isSecret cfg.ipv6)
            ''
              [Network]
              ${
                lib.optionalString (isSecret cfg.ipv4)
                "Address=${config.sops.placeholder.${cfg.ipv4.secretName}}/${toString cfg.prefixLength4}"
              }
              ${
                lib.optionalString (isSecret cfg.ipv6)
                "Address=${config.sops.placeholder.${cfg.ipv6.secretName}}/${toString cfg.prefixLength6}"
              }
            '';
          owner = "root";
          group = "systemd-network";
          mode = "0440";
        };
        sops.templates.networkd-route = {
          content =
            lib.mkIf
            (isSecret cfg.defaultGateway || isSecret cfg.defaultGateway6)
            "${
              lib.optionalString (isSecret cfg.defaultGateway)
              ''
                [Route]
                Gateway=${config.sops.placeholder.${cfg.defaultGateway.secretName}}
                Destination=0.0.0.0/0
              ''
            }\n${
              lib.optionalString (isSecret cfg.defaultGateway6)
              ''
                [Route]
                Gateway=${config.sops.placeholder.${cfg.defaultGateway6.secretName}}
                Destination=::/0
              ''
            }";
          owner = "root";
          group = "systemd-network";
          mode = "0440";
        };
      })
  ]
