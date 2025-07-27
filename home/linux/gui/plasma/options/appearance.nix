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

    panels = [
      {
        height = 44;
        location = "bottom";
        lengthMode = "fill";
        alignment = "center";
        hiding = "none";
        floating = true;
        widgets = [
          "org.kde.plasma.kickoff"
          "org.kde.plasma.pager"
          "org.kde.plasma.icontasks"
          "org.kde.plasma.marginsseparator"
          "org.kde.plasma.systemtray"
          "org.kde.plasma.digitalclock"
          "org.kde.plasma.showdesktop"
        ];
        screen = "all";
        opacity = "translucent";
      }
    ];

    configFile.dolphinrc.IconsMode = {
      IconSize = 128;
      PreviewSize = 128;
    };
  };
}
