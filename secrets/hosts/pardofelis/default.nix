{
  config,
  lib,
  hostName,
  ...
}:
lib.mkIf (hostName == "pardofelis") {
  sops.secrets.pardofelis-network = {
    format = "yaml";
    key = "content";
    sopsFile = ./secrets.yaml;
    owner = "root";
    group = "systemd-network";
    mode = "0440";
    path = "/etc/systemd/network/10-${config.modules.my-hosts.${hostName}.network.iface}.network.d/99-secret-ip.conf";
  };
  services.openssh.hostKeys = [
    {
      path = "/etc/ssh/ssh_host_ed25519_key";
      type = "ed25519";
    }
  ];
}
