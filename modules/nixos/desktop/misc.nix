{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}: {
  # add user's shell into /etc/shells
  environment.shells = with pkgs; [
    bashInteractive
    pkgs.fish
  ];
  # set user's default shell system-wide
  users.defaultUserShell = pkgs.bashInteractive;

  # fix for `sudo xxx` in kitty/wezterm/foot and other modern terminal emulators
  security.sudo.keepTerminfo = true;

  environment.variables = {
    # fix https://github.com/NixOS/nixpkgs/issues/238025
    TZ = "${config.time.timeZone}";
  };

  services = {
    gvfs.enable = true; # Mount, trash, and other functionalities
    tumbler.enable = true; # Thumbnail support for images
  };
}
