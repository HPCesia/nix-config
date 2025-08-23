{...}: {
  programs.helix.languages = {
    language = [
      {
        name = "html";
        auto-format = true;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        language-servers = ["vscode-html-language-server" "tailwindcss-ls"];
        formatter = {
          command = "prettier";
          args = ["--parser" "html" "--stdin-filepath" "%{buffer_name}"];
        };
      }
    ];
  };
}
