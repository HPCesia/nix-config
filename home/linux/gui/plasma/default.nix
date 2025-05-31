{plasma-manager, ...}: {
  imports = [
    plasma-manager.homeManagerModules.plasma-manager
    ./options
  ];

  programs.plasma = {
    enable = true;
  };
}
