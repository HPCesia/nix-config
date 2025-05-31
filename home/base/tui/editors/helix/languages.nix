{...}: {
  programs.helix.languages = {
    language = [
      {
        name = "nix";
        auto-format = true;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        formatter = {command = "alejandra";};
      }
      {
        name = "typst";
        auto-format = true;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        formatter = {command = "typstyle";};
      }
    ];
  };
}
