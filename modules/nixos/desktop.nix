{
  pkgs,
  config,
  lib,
  myvars,
  ...
}: {
  imports = [
    ./base
    ../base.nix
    ./desktop
  ];

  services = {
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
    xserver = {
      enable = true;
      xkb.layout = "us";
    };
    displayManager = {
      sddm.enable = true;
      autoLogin = {
        enable = true;
        user = myvars.username;
      };
      defaultSession = "plasma";
    };
    desktopManager.plasma6.enable = true;
  };
}
