{...}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.nushell = {
    enable = true;
  };
}
