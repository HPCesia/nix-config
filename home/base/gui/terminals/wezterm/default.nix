{
  config,
  pkgs-unstable,
  ...
}: let
  configPath = "${config.home.homeDirectory}/nix-config/home/base/gui/terminals/wezterm/config";
in {
  home.file.".config/wezterm".source = config.lib.file.mkOutOfStoreSymlink configPath;

  programs.wezterm = {
    enable = true;
    package = pkgs-unstable.wezterm;
  };
}
