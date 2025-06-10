{...}: let
  shellAliases = {
    "zj" = "zellij";
  };
in {
  catppuccin.zellij.enable = true;

  programs.zellij = {
    enable = true;
    settings = {
      show_startup_tips = false;
      show_release_notes = false;
      default_shell = "nu";
    };
  };

  # auto start zellij in nushell
  programs.nushell.extraConfig = ''
    # auto start zellij
    # except when in VSCode or zellij itself
    if (not ("ZELLIJ" in $env)) and (not ($env.TERM_PROGRAM? == "vscode")) {
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
