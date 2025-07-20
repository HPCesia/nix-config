{...}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.fish = {
    enable = true;
  };

  programs.nushell = {
    enable = true;
    settings = {
      show_banner = false;
    };
  };
}
