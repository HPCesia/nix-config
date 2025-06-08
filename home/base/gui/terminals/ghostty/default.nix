{config, ...}: {
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      theme = "catppuccin-${config.catppuccin.flavor}";
      window-padding-x = 5;
      window-padding-y = 5;
    };
  };
}
