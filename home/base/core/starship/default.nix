{...}: {
  catppuccin.starship.enable = true;

  programs.starship = {
    enable = true;

    enableBashIntegration = true;
    enableFishIntegration = true;

    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
}
