{
  pkgs,
  programsdb,
  ...
}: {
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

  home.file.".nix-defexpr/channels/nixpkgs/programs.sqlite" = {
    source = programsdb.packages.${pkgs.system}.programs-sqlite;
    force = true;
  };
}
