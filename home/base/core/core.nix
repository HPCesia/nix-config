{pkgs, ...}: {
  home.packages = with pkgs; [
    gnupg

    fzf # Interactively filter its input using fuzzy searching, not limit to filenames.
    fd # search for files by name, faster than find
    ripgrep # search for files by its content, replacement of grep

    yq-go # yaml processor https://github.com/mikefarah/yq
    delta # A viewer for git and diff output
    lazygit # Git terminal UI.
  ];

  programs = {
    # A command-line fuzzy finder
    fzf = {
      enable = true;
    };

    # zoxide is a smarter cd command, inspired by z and autojump.
    # It remembers which directories you use most frequently,
    # so you can "jump" to them in just a few keystrokes.
    # zoxide works on all major shells.
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableZshIntegration = true;
      enableNushellIntegration = true;
    };
  };
}
