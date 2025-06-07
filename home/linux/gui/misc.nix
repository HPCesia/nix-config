{
  pkgs,
  lib,
  ...
}: let
  inherit (lib.lists) concatLists;

  # Fix Electron IME bug
  cherrystudio = pkgs.cherry-studio.override {
    commandLineArgs = concatLists [
      ["--ozone-platform-hint=auto"]
      ["--enable-wayland-ime"]
      ["--wayland-text-input-version=3"]
    ];
  };
in {
  home.packages = with pkgs; [
    chromium

    thunderbird

    # Message
    telegram-desktop
    qq
    wechat-uos

    # Misc
    cherrystudio
    obs-studio
  ];

  # allow fontconfig to discover fonts and configurations installed through home.packages
  # Install fonts at system-level, not user-level
  fonts.fontconfig.enable = false;
}
