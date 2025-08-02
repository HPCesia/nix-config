{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  myvars,
  ...
}: {
  # `programs.git` will generate the config file: ~/.config/git/config
  # to make git use this config file, `~/.gitconfig` should not exist!
  #
  #    https://git-scm.com/docs/git-config#Documentation/git-config.txt---global
  home.activation.removeExistingGitconfig = lib.hm.dag.entryBefore ["checkLinkTargets"] ''
    rm -f ${config.home.homeDirectory}/.gitconfig
  '';

  programs.git = {
    enable = true;
    lfs.enable = true;

    userName = myvars.userfullname;
    userEmail = myvars.useremail;

    extraConfig = {
      init.defaultBranch = "main";
      trim.bases = "develop,master,main"; # for git-trim
      push.autoSetupRemote = true;
      pull.rebase = true;

      # replace https with ssh
      url = {
        "ssh://git@github.com/HPCesia" = {
          insteadOf = "https://github.com/HPCesia";
        };
        "ssh://git@codeberg.org/HPCesia" = {
          insteadOf = "https://codeberg.org/HPCesia";
        };
        "ssh://git@repo.hpcesia.com:2222/HPCesia" = {
          insteadOf = "https://repo.hpcesia.com/HPCesia";
        };
      };
    };

    # A syntax-highlighting pager in Rust(2019 ~ Now)
    delta = {
      enable = true;
      options = {
        diff-so-fancy = true;
        line-numbers = true;
        true-color = "always";
      };
    };
  };

  programs.jujutsu = {
    enable = true;
    package = pkgs-unstable.jujutsu;
    settings = {
      user = {
        name = myvars.userfullname;
        email = myvars.useremail;
      };
      ui = {
        editor = "hx";
        diff-formatter = "delta";
      };
      merge-tools.delta.diff-expected-exit-codes = [0 1];
    };
  };
}
