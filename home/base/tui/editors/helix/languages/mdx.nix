{...}: {
  programs.helix.languages = {
    language = [
      {
        name = "mdx";
        scope = "source.mdx";
        injection-regex = "mdx";
        file-types = ["mdx"];
        block-comment-tokens = {
          start = "<!--";
          end = "-->";
        };
        auto-format = false;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        roots = [
          ".prettierignore"
          ".prettierrc"
          ".prettierrc.cjs"
          ".prettierrc.mjs"
          ".prettierrc.js"
        ];
        formatter = {
          command = "prettier";
          args = ["--parser" "mdx" "--stdin-filepath %{buffer_name}"];
        };
        language-servers = ["mdx-language-server"];
      }
    ];
    grammar = [
      {
        name = "mdx";
        source = {
          git = "https://github.com/parmort/tree-sitter-mdx";
          rev = "413285231ce8fa8b11e7074bbe265b48aa7277f9";
        };
      }
    ];
    language-server.mdx-language-server = {
      command = "mdx-language-server";
      args = ["--stdio"];
    };
  };
}
