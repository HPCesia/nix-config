{...}: {
  programs.helix.languages = {
    language = [
      {
        name = "lua";
        auto-format = true;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        formatter = {
          command = "stylua";
          args = [
            "--indent-type"
            "Spaces"
            "--indent-width"
            "2"
            "--column-width"
            "80"
            "--call-parentheses"
            "NoSingleTable"
            "--sort-requires"
            "-" # From stdin
          ];
        };
        roots = [
          "stylua.toml"
          ".stylua.toml"
          ".editorconfig"
        ];
      }
    ];
    language-server.lua-language-server = {
      command = "lua-language-server";
      args = ["--locale=zh-cn"];
      config.Lua = {
        format.enable = false;
      };
    };
  };
}
