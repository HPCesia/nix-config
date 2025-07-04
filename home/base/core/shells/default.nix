{...}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
    };
  };

  catppuccin.nushell.enable = true;
}
