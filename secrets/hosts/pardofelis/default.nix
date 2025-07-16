{
  lib,
  config,
  ...
}: let
  secretFileConf = {
    format = "yaml";
    sopsFile = ./secrets.yaml;
  };
in
  lib.mkMerge (
    [
      {
        sops.secrets = builtins.listToAttrs (builtins.map (x: {
          name = "pardofelis-${x}";
          value =
            {
              key = x;
            }
            // secretFileConf;
        }) ["ipv4" "ipv6" "gateway" "gateway6"]);
      }
    ]
    ++ lib.map (nvp: {
      sops.secrets.${nvp.name} =
        lib.mkIf
        (config.modules.currentHost == "pardofelis")
        nvp.value;
    }) [
      {
        name = "freshrss-admin-password";
        value =
          {
            key = "services/freshrss/defaultUserPassword";
            owner = "root";
            group = "freshrss";
            mode = "0440";
          }
          // secretFileConf;
      }
      {
        name = "grafana-admin-password";
        value =
          {
            key = "services/grafana/adminPassword";
            owner = "root";
            group = "grafana";
            mode = "0440";
          }
          // secretFileConf;
      }
    ]
  )
