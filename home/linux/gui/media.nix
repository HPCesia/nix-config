{pkgs, ...}: let
  audacious = (pkgs.audacious.override {withPlugins = true;}).overrideAttrs (
    previousAttrs: {
      qtWrapperArgs =
        (previousAttrs.qtWrapperArgs or [])
        ++ [
          "--set GTK_IM_MODULE wayland"
          "--set QT_IM_MODULE fcitx"
        ];
    }
  );
in {
  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      scripts = [pkgs.mpvScripts.mpris];
    };
  };

  home.packages = with pkgs; [
    audacious
  ];
}
