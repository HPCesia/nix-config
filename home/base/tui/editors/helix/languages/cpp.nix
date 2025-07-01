{...}: {
  programs.helix.languages = {
    language = [
      {
        name = "c";
        auto-format = true;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
      }
      {
        name = "cpp";
        auto-format = true;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
      }
    ];
    language-server.clangd = {
      command = "clangd";
      args = [
        "--all-scopes-completion"
        "--completion-parse=auto"
        "--completion-style=detailed"
        "--background-index"
        "--clang-tidy"
        "--fallback-style=LLVM"
      ];
    };
  };
}
