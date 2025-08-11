{...}: {
  programs.plasma.configFile = {
    kdeglobals = {
      General = {
        TerminalApplication = "ghostty";
        TerminalService = "com.mitchellh.ghostty";
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
