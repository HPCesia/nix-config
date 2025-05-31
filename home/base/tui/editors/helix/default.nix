{...}: {
  imports = [./languages.nix];

  catppuccin.helix.enable = true;

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
