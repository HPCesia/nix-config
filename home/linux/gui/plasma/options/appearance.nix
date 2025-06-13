{
  pkgs,
  config,
  wallpapers,
  ...
}: let
  catppuccin-kde = pkgs.catppuccin-kde.override {
    flavour = [config.catppuccin.flavor];
    accents = [config.catppuccin.accent];
  };
in {
  home.packages = [catppuccin-kde];

  programs.plasma = {
    kscreenlocker.appearance.wallpaper = "${wallpapers}/default_wallpaper";

    workspace = {
      wallpaper = "${wallpapers}/default_wallpaper";
      theme = "breeze-dark";
      colorScheme = "CatppuccinMacchiatoMauve";
    };
  };
}
