{...}: let
  stylelintRoots = [
    ".stylelintrc"
    ".stylelintrc.mjs"
    ".stylelintrc.cjs"
    ".stylelintrc.js"
    ".stylelintrc.json"
    ".stylelintrc.yaml"
    ".stylelintrc.yml"
    "stylelint.config.mjs"
    "stylelint.config.cjs"
    "stylelint.config.js"
  ];
in {
  programs.helix.languages = {
    language = [
      {
        name = "css";
        auto-format = true;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        roots = stylelintRoots;
        language-servers = ["stylelint-lsp" "tailwindcss-ls"];
      }
      {
        name = "scss";
        auto-format = true;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        roots = stylelintRoots;
        language-servers = ["stylelint-lsp" "tailwindcss-ls"];
      }
    ];
    language-server = {
      stylelint-lsp = {
        command = "stylelint-lsp";
        args = ["--stdio"];
        config = {
          autoFixOnFormat = true;
        };
      };
    };
  };
}
