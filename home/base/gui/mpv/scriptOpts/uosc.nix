{...}: {
  # programs.mpv.extraInput = ''
  #   MBTN_RIGHT script-binding uosc/menu
  # '';
  programs.mpv.scriptOpts.uosc = {
    languages = "slang,zh-hans";
  };
}
