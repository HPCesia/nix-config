{pkgs-unstable, ...}: {
  # Refer: /options/home/helixSteelEventSystem.nix
  programs.helix.steelEventSystem = {
    enable = true;
    steelPackage = pkgs-unstable.steel;
  };
}
