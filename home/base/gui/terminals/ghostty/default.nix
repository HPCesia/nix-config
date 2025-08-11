{...}: {
  programs.ghostty = {
    enable = true;
    enableBashIntegration = true;
    enableFishIntegration = true;
    settings = {
      font-family = "Maple Mono NF CN";
      command = "fish";
      window-padding-x = 5;
      window-padding-y = 5;
      window-padding-balance = true;
      window-height = 32;
      window-width = 128;
      window-new-tab-position = "current";
      copy-on-select = false;
    };
  };
}
