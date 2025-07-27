{...}: {
  programs.plasma.configFile = {
    kdeglobals = {
      General = {
        TerminalApplication = "wezterm start --cwd .";
        TerminalService = "org.wezfurlong.wezterm.desktop";
      };
    };
    plasma-localerc = {
      Formats.LANG = "zh_CN.UTF-8";
      Translations.LANGUAGE = "zh_CN";
    };
    kwinrc = {
      Wayland.InputMethod = {
        shellExpand = true;
        value = "/etc/profiles/per-user/hpcesia/share/applications/fcitx5-wayland-launcher.desktop";
      };
    };
  };
}
