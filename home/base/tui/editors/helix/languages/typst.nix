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
        soft-wrap.enable = true;
      }
    ];
    language-server.tinymist.config = {
      formatterMode = "typstyle";
      formatterIndentSize = 2;
    };
  };
}
