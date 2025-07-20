{...}: {
  programs.starship = {
    enable = true;

    enableBashIntegration = true;
    enableFishIntegration = true;
    enableNushellIntegration = true;

    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
}
