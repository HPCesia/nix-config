{pkgs, ...}: let
  fcitx5-rime = pkgs.fcitx5-rime.override {
    rimeDataPkgs = [pkgs.nur.repos.xyenon.rime-ice];
  };
in {
  catppuccin.fcitx5.enable = true;

  xdg.configFile = {
    "fcitx5/profile" = {
      source = ./profile;
      # every time fcitx5 switch input method, it will modify ~/.config/fcitx5/profile,
      # so we need to force replace it in every rebuild to avoid file conflict.
      force = true;
    };
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5 = {
      # To fix configtool in plasma6
      fcitx5-with-addons = pkgs.qt6Packages.fcitx5-with-addons;
      addons = with pkgs; [
        fcitx5-rime
        fcitx5-gtk # gtk im module
      ];
      waylandFrontend = true;
    };
  };
}
