{
  config,
  pkgs-unstable,
  ...
}: let
  configPath = "${config.home.homeDirectory}/nix-config/home/base/gui/terminals/wezterm/config";
in {
  xdg.configFile."wezterm".source = config.lib.file.mkOutOfStoreSymlink configPath;

  catppuccin.wezterm.enable = false;

  programs.wezterm = {
    # enable = true;
    package = pkgs-unstable.wezterm;
  };
}
