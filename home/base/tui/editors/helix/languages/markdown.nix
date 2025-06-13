{...}: {
  programs.helix.languages = {
    language = [
      {
        name = "markdown";
        auto-format = true;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        formatter = {
          command = "prettier";
        };
        language-servers = ["marksman"];
      }
    ];
  };
}
