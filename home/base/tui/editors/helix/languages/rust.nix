{...}: {
  programs.helix.languages = {
    language = [
      {
        name = "rust";
        auto-format = true;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
      }
    ];
    language-server.rust-analyzer.config = {
    };
  };
}
