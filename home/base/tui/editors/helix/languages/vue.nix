{pkgs, ...}: {
  programs.helix.languages = {
    language = [
      {
        name = "vue";
        scope = "text.html.vue";
        auto-format = true;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        language-servers = ["vuels" "typescript-language-server" "tailwindcss-ls"];
        formatter = {
          command = "prettier";
          args = ["--stdin-filepath %{buffer_name}"];
        };
      }
    ];
    language-server = {
      vuels = {
        command = "vue-language-server";
        args = ["--stdio"];
        config = {
          typescript.tsdk = "node_modules/typescript/lib/";
        };
      };
      typescript-language-server.config = {
        plugins = [
          {
            name = "@vue/typescript-plugin";
            location = "${pkgs.vue-language-server}/lib/language-tools/packages/language-server";
            languages = ["vue"];
          }
        ];
      };
    };
  };
}
