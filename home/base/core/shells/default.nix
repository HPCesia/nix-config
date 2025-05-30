{
  config,
  pkgs,
  ...
}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
  };

  programs.fish = {
    enable = true;
  };
}
