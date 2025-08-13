{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    # Misc
    gnupg
    gnumake

    fd # search for files by name, faster than find
    ripgrep # search for files by its content, replacement of grep
    yq-go # yaml processor https://github.com/mikefarah/yq
    delta # A viewer for git and diff output
    gping # ping, but with a graph(TUI)
    websocat # Command-line client for WebSockets

    # nix related
    nix-index # A small utility to index nix store paths
    nix-init # generate nix derivation from url
    nix-melt # A TUI flake.lock viewer
    nix-tree # A TUI to visualize the dependency graph of a nix derivation
  ];

  programs = {
    # A command-line fuzzy finder
    fzf = {
      enable = true;
    };

    # a cat(1) clone with syntax highlighting and Git integration.
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
    };

    # zoxide is a smarter cd command, inspired by z and autojump.
    # It remembers which directories you use most frequently,
    # so you can "jump" to them in just a few keystrokes.
    # zoxide works on all major shells.
    zoxide = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    carapace = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
    };

    # rbw, a unofficial CLI Bitwarden client
    rbw = {
      enable = true;
      settings = {
        base_url = "https://bitwarden.hpcesia.com/";
        email = "me@hpcesia.com";
        pinentry = lib.mkDefault pkgs.pinentry-tty;
      };
    };

    # very fast version of tldr in Rust
    tealdeer = {
      enable = true;
      enableAutoUpdates = true;
      settings = {
        display = {
          compact = false;
          use_pager = true;
        };
        updates = {
          auto_update = false;
          auto_update_interval_hours = 720;
        };
      };
    };

    # Atuin replaces your existing shell history with a SQLite database,
    # and records additional context for your commands.
    # Additionally, it provides optional and fully encrypted
    # synchronisation of your history between machines, via an Atuin server.
    atuin = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      enableNushellIntegration = true;
      package = pkgs-unstable.atuin;
      settings = {
        sync_address = "https://atuin.hpcesia.com";
        sync_frequency = "10m";
        filter_mode = "host";
        style = "full";
        inline_height = 32;
        keymap_mode = "vim-normal";
      };
    };

    eza = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      icons = "auto";
      git = true;
    };
  };
}
