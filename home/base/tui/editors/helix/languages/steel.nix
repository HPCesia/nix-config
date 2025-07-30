{...}: {
  programs.helix.languages = {
    language = [
      {
        name = "scheme";
        auto-format = true;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        language-servers = ["steel-language-server"];
      }
    ];
    language-server.steel-language-server = {
      command = "steel-language-server";
      args = [];
    };
  };
}
