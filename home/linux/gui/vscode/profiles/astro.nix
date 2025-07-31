{pkgs, ...}: {
  Astro = {
    userSettings = {
      "javascript.suggest.paths" = false;
      "typescript.suggest.paths" = false;
    };

    extensions = with pkgs.vscode-extensions; [
      astro-build.astro-vscode # Astro LSP
      vue.volar # Vue LSP
      bradlc.vscode-tailwindcss # Tailwind CSS LSP
      unifiedjs.vscode-mdx # MDX LSP

      dbaeumer.vscode-eslint
      esbenp.prettier-vscode
    ];
  };
}
