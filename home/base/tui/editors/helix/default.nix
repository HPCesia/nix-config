{...}: {
  imports = [./languages ./steel-config];

  programs.helix = {
    settings = {
      editor = {
        cursorline = true;
        color-modes = true;
        lsp.display-messages = true;
        indent-guides.render = true;
      };
    };
  };
}
