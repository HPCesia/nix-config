{...}: {
  programs.plasma = {
    shortcuts = {
      "services/org.wezfurlong.wezterm.desktop"._launch = "Meta+`";
    };
    hotkeys.commands = {
      pot = {
        comment = "Pot 划词翻译";
        command = "curl \"127.0.0.1:60828/selection_translate\"";
        key = "Meta+Alt+Q";
      };
    };
  };
}
