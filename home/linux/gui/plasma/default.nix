{plasma-manager, ...}: {
  imports = [
    plasma-manager.homeManagerModules.plasma-manager
    ./options
    ./apps
  ];

  programs.plasma = {
    enable = true;
  };
}
