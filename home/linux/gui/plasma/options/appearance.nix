{
  pkgs,
  config,
  ...
}: let
  catppuccin-kde = pkgs.catppuccin-kde.override {
    flavour = [config.catppuccin.flavor];
    accents = [config.catppuccin.accent];
  };
in {
  home.packages = [catppuccin-kde];

  programs.plasma.workspace = {
    theme = "breeze-dark";
    colorScheme = "CatppuccinMacchiatoMauve";
  };
}
