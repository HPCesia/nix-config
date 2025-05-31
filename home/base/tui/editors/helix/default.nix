{...}: {
  imports = [./languages.nix];

  programs.helix = {
    editor = {
      cursorline = true;
      color-modes = true;
      lsp.display-messages = true;
      indent-guides.render = true;
    };
  };
}
