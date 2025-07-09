{...}: {
  programs.starship = {
    enable = true;

    enableBashIntegration = true;
    enableNushellIntegration = true;

    settings = builtins.fromTOML (builtins.readFile ./starship.toml);
  };
}
