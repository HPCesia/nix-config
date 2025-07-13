{
  lib,
  config,
  pkgs,
  ...
}: {
  services.mihomo = {
    enable = lib.mkDefault true;
    tunMode = true;
    webui = pkgs.metacubexd;
    configFile = config.sops.templates."mihomo-config.yaml".path;
  };

  networking.firewall.trustedInterfaces = [
    "ElysianRealm"
  ];

  sops.templates."mihomo-config.yaml".content =
    ''
      NodeParam:
        &NodeParam {
          type: http,
          interval: 86400,
          health-check:
            { enable: true, url: "http://cp.cloudflare.com", interval: 300 },
        }
      proxy-providers:
        Node-YiYuan:
          url: "${config.sops.placeholder."mihomo/providers/yi_yuan"}"
          <<: *NodeParam
          path: "./proxy_provider/providers-yi_yuan.yaml"
          override:
            additional-prefix: "[YY]"
        Node-MoJie:
          url: "${config.sops.placeholder."mihomo/providers/mo_jie"}"
          <<: *NodeParam
          path: "./proxy_provider/providers-mo_jie.yaml"
          override:
            additional-prefix: "[MJ]"
    ''
    + "\n"
    + builtins.readFile ./config.yaml;
}
