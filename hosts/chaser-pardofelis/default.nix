{
  mylib,
  myvars,
  disko,
  ...
}:
#############################################################
#
#  Pardofelis - NixOS running on a 2C4G VPS
#  My main server hosted by Yecaoyun.
#
#############################################################
let
  hostName = "pardofelis"; # Define your hostname.
in {
  imports =
    (mylib.scanModules ./.)
    ++ [
      disko.nixosModules.default
    ];

  modules.my-hosts.${hostName} = {
    network = {
      enable = "networkd";
      iface = "eth0";
      useDHCP = false;
      nameservers = ["172.16.36.100"] ++ myvars.defaultNameservers;
      search = ["local"];
    };
    hostPublicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIO56HKTdzGulisPLhpfUmLQNEgwDqwD9SBLRb5aETffV root@pardofelis";
    sshPorts = [23930];
  };

  systemd.network.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
