{config, ...}: let
  NodeParam = {
    type = "http";
    interval = 86400;
    health-check = {
      enable = true;
      url = "http://cp.cloudflare.com";
      interval = 300;
    };
  };
in {
  services.mihomo.config.proxy-providers = {
    "Node-YiYuan" =
      NodeParam
      // {
        url = config.sops.placeholder."mihomo/providers/yi_yuan";
        path = "./proxy_provider/providers-yi_yuan.yaml";
        override.additional-prefix = "[YY]";
      };
    "Node-MoJie" =
      NodeParam
      // {
        url = config.sops.placeholder."mihomo/providers/mo_jie";
        path = "./proxy_provider/providers-mo_jie.yaml";
        override.additional-prefix = "[MJ]";
      };
  };
}
