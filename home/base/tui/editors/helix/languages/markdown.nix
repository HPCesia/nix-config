{...}: {
  programs.helix.languages = {
    language = [
      {
        name = "markdown";
        auto-format = false;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        soft-wrap.enable = true;
        roots = [
          ".prettierignore"
          ".prettierrc"
          ".prettierrc.cjs"
          ".prettierrc.mjs"
          ".prettierrc.js"
          ".marksman.toml"
        ];
        formatter = {
          command = "prettier";
          args = ["--parser" "markdown" "--stdin-filepath" "%{buffer_name}"];
        };
        language-servers = ["marksman"];
      }
    ];
  };
}
