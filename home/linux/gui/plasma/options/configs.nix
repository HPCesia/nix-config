{...}: {
  programs.plasma.configFile = {
    kdeglobals = {
      General = {
        TerminalApplication = "wezterm start --cwd .";
        TerminalService = "org.wezfurlong.wezterm.desktop";
      };
    };
  };
}
