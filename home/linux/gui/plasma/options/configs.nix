{...}: {
  programs.plasma.configFile = {
    kdeglobals = {
      General = {
        TerminalApplication = "ghostty";
        TerminalService = "com.mitchellh.ghostty";
      };
    };
  };
}
