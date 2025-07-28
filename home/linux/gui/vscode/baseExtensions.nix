pkgs: (with pkgs.vscode-extensions;
  [
    # Translation
    # ms-ceintl.vscode-language-pack-zh-hans
    w88975.code-translate

    # Appearance
    pkief.material-icon-theme
    catppuccin.catppuccin-vsc

    # Utils
    mhutchie.git-graph
    christian-kohler.path-intellisense
    usernamehw.errorlens
    shardulm94.trailing-spaces
    gruntfuggly.todo-tree

    # LLM
    github.copilot
    github.copilot-chat

    # Nix
    jnoortheen.nix-ide

    # Nushell
    thenuprojectcontributors.vscode-nushell-lang

    # Configuration languages
    tamasfe.even-better-toml
    redhat.vscode-yaml
  ]
  ++ pkgs.vscode-utils.extensionsFromVscodeMarketplace [
    {
      name = "git-commit-plugin";
      publisher = "redjue";
      version = "1.5.0";
      sha256 = "fOdeUuB4jFL0LvGsLcjz5EQslD8jRRGslbumMo3cZCs=";
    }
    {
      name = "aw-watcher-vscode";
      publisher = "activitywatch";
      version = "0.5.0";
      sha256 = "OrdIhgNXpEbLXYVJAx/jpt2c6Qa5jf8FNxqrbu5FfFs=";
    }
  ])
