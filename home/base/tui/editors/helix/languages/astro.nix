{...}: {
  programs.helix.languages = {
    language = [
      {
        name = "astro";
        auto-format = true;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        language-servers = ["astro-ls" "tailwindcss-ls"];
      }
    ];
    language-server = {
      astro-ls = {
        command = "astro-ls";
        args = ["--stdio"];
        config = {
          typescript = {
            tsdk = "node_modules/typescript/lib";
            environment = "node";
          };
          contentIntellisense = true;
        };
      };
    };
  };
}
