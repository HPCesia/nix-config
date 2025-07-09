{...}: {
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      window-padding-x = 5;
      window-padding-y = 5;
    };
  };
}
