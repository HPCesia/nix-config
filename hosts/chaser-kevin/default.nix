{
  nixos-hardware,
  myvars,
  ...
}:
#############################################################
#
#  Kevin - NixOS running on ThinkBook 16P G5 IRX
#  My main computer, with I7-14650HX + RTX4060 Laptop GPU + 48GB memory, for daily use.
#
#############################################################
let
  hostName = "kevin";
in {
  imports = [
    nixos-hardware.nixosModules.common-cpu-intel
    nixos-hardware.nixosModules.common-hidpi
    nixos-hardware.nixosModules.common-pc-laptop
    nixos-hardware.nixosModules.common-pc-laptop-ssd
    ./nvidia.nix
    ./hardware-configuration.nix
    ./miscs.nix
    ./boot.nix
  ];

  modules.currentHost = hostName;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}
