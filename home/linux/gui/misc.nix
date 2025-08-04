{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: let
  inherit (lib.lists) concatLists;

  chromiumCLA = concatLists [
    ["--ozone-platform-hint=auto"]
    ["--enable-wayland-ime"]
    ["--wayland-text-input-version=3"]
  ];

  # Fix Chromium IME bug
  cherrystudio = pkgs-unstable.cherry-studio.override {commandLineArgs = chromiumCLA;};
  chromium = pkgs.chromium.override {commandLineArgs = chromiumCLA ++ ["-–disable-features=GlobalShortcutsPortal"];};
  qq = pkgs.qq.override {commandLineArgs = chromiumCLA;};
in {
  home.packages = with pkgs; [
    # Message
    telegram-desktop
    qq
    wechat

    # Misc
    cherrystudio
    obs-studio
    gimp3
    pot
  ];

  programs.chromium = {
    enable = true;
    package = chromium;
    nativeMessagingHosts = [pkgs.kdePackages.plasma-browser-integration];
    extensions = [
      {id = "cimiefiiaegbelhefglklhhakcgmhkai";} # Plasma Integration
      # {id = "bpoadfkcbjbfhfodiogcnhhhpibjhbnh";} # Immersive Translate
    ];
  };

  # allow fontconfig to discover fonts and configurations installed through home.packages
  # Install fonts at system-level, not user-level
  fonts.fontconfig.enable = false;
}
