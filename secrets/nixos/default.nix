let
  mapSecrets = keys:
    builtins.listToAttrs (builtins.map (k: {
        name = k;
        value = {
          format = "yaml";
          sopsFile = ./secrets.yaml;
        };
      })
      keys);
in {
  sops.secrets = mapSecrets [
    "mihomo/providers/yi_yuan"
    "mihomo/providers/mo_jie"
    "aria2-rpc-secret"
  ];
}
