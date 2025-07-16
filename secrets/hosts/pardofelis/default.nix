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
  lib.mkMerge [
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
    {
      sops.secrets."freshrss-admin-password" =
        lib.mkIf
        (config.modules.currentHost == "pardofelis")
        (
          {
            key = "services/freshrss/defaultUserPassword";
            owner = "root";
            group = "freshrss";
            mode = "0440";
          }
          // secretFileConf
        );
    }
  ]
