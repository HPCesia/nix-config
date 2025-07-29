{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: let
  inherit (lib.lists) concatLists;

  chromiumCLA = {
    commandLineArgs = concatLists [
      ["--ozone-platform-hint=auto"]
      ["--enable-wayland-ime"]
      ["--wayland-text-input-version=3"]
    ];
  };

  # Fix Chromium IME bug
  cherrystudio = pkgs-unstable.cherry-studio.override chromiumCLA;
  chromium = pkgs.chromium.override chromiumCLA;
  qq = pkgs.qq.override chromiumCLA;
in {
  home.packages = with pkgs; [
    chromium

    # Message
    telegram-desktop
    qq
    wechat-uos

    # Misc
    cherrystudio
    obs-studio
    gimp3
    pot
  ];

  # allow fontconfig to discover fonts and configurations installed through home.packages
  # Install fonts at system-level, not user-level
  fonts.fontconfig.enable = false;
}
