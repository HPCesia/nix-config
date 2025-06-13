{...}: {
  programs.helix.languages = {
    language = [
      {
        name = "typst";
        auto-format = true;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
      }
    ];
    language-server.tinymist = {
      formatterMode = "typstyle";
      formatterIndentSize = 2;
    };
  };
}
