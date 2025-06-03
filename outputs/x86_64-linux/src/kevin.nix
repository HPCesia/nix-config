{
  # NOTE: the args not used in this file CAN NOT be removed!
  # because haumea pass argument lazily,
  # and these arguments are used in the functions `mylib.nixosSystem`.
  inputs,
  lib,
  myvars,
  mylib,
  system,
  genSpecialArgs,
  ...
} @ args: let
  # Kevin - Codename "Deliverance", 1st of Flame-Chasers
  name = "kevin";
  base-modules = {
    nixos-modules = map mylib.relativeToRoot [
      # common
      "secrets/nixos.nix"
      "modules/nixos/desktop.nix"
      # host specific
      "hosts/chaser-${name}"
    ];
    home-modules = map mylib.relativeToRoot [
      # common
      "home/linux/gui.nix"
      # host specific
      "hosts/chaser-${name}/home.nix"
    ];
  };
in {
  nixosConfigurations = {
    "${name}" = mylib.nixosSystem (base-modules // args);
  };
}
