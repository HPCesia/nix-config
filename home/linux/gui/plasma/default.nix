{plasma-manager, ...}: {
  imports = [
    plasma-manager.homeManagerModules.plasma-manager
    ./options
    ./application.nix
  ];

  programs.plasma = {
    enable = true;
  };
}
