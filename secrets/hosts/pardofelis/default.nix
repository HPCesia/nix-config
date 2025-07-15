{
  sops.secrets = builtins.listToAttrs (builtins.map (x: {
    name = "pardofelis-${x}";
    value = {
      format = "yaml";
      sopsFile = ./secrets.yaml;
      key = x;
    };
  }) ["ipv4" "ipv6" "gateway" "gateway6"]);
}
