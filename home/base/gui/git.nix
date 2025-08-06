{...}: {
  programs.git.signing = {
    signByDefault = true;
    format = "openpgp";
  };

  programs.jujutsu.settings.signing = {
    behavior = "own";
    backend = "gpg";
  };
}
