{
  pkgs,
  lib,
  ...
}: {
  Tauri = {
    userSettings =
      {
        "javascript.suggest.paths" = false;
        "typescript.suggest.paths" = false;
        "rust-analyzer.server.path" = lib.getExe pkgs.rust-analyzer;
      }
      // (lib.genAttrs [
          "[javascript]"
          "[typescript]"
          "[vue]"
        ] (_: {
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "editor.codeActionsOnSave"."source.fixAll.eslint" = "always";
        }));

    extensions = with pkgs.vscode-extensions; [
      vue.volar # Vue LSP
      bradlc.vscode-tailwindcss # Tailwind CSS LSP
      rust-lang.rust-analyzer # Rust LSP
      tauri-apps.tauri-vscode # Tauri LSP

      dbaeumer.vscode-eslint
      esbenp.prettier-vscode
      stylelint.vscode-stylelint
    ];
  };
}
