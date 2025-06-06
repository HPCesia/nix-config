{pkgs, ...}: {
  catppuccin.yazi.enable = true;

  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    settings = {
      manager = {
        show_hidden = true;
        sort_dir_first = true;
      };
    };
  };
}
