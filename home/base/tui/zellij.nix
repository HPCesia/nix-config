{...}: let
  shellAliases = {
    "zj" = "zellij";
  };
in {
  catppuccin.zellij.enable = true;

  programs.zellij = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      show_startup_tips = false;
      show_release_notes = false;
    };
  };

  # auto start zellij in nushell
  programs.nushell.extraConfig = ''
    # auto start zellij
    # except when in emacs or zellij itself
    if (not ("ZELLIJ" in $env)) and (not ("INSIDE_EMACS" in $env)) {
      if "ZELLIJ_AUTO_ATTACH" in $env and $env.ZELLIJ_AUTO_ATTACH == "true" {
        ^zellij attach -c
      } else {
        ^zellij
      }

      # Auto exit the shell session when zellij exit
      $env.ZELLIJ_AUTO_EXIT = "false" # disable auto exit
      if "ZELLIJ_AUTO_EXIT" in $env and $env.ZELLIJ_AUTO_EXIT == "true" {
        exit
      }
    }
  '';

  # only works in bash/zsh, not nushell
  home.shellAliases = shellAliases;
  programs.nushell.shellAliases = shellAliases;
}
