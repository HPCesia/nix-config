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
  home.packages = with pkgs; [
    audacious
  ];
}
