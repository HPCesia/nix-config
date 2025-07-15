{myvars, ...}: {
  modules.my-hosts = {
    kevin.network = {
      enable = "networkmanager";
      iface = "wlp0s20f3";
      useDHCP = true;
      nameservers = myvars.defaultNameservers;
    };

    pardofelis = {
      network = {
        enable = "networkd";
        iface = "eth0";
        useDHCP = false;
        nameservers = ["172.16.36.100"] ++ myvars.defaultNameservers;
        search = ["local"];
        ipv4 = {secretName = "pardofelis-ipv4";};
        ipv6 = {secretName = "pardofelis-ipv6";};
        defaultGateway = {secretName = "pardofelis-gateway";};
        defaultGateway6 = {secretName = "pardofelis-gateway6";};
      };
      hostPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO56HKTdzGulisPLhpfUmLQNEgwDqwD9SBLRb5aETffV root@pardofelis";
      sshPorts = [23930];
    };
  };
}
