{pkgs, ...}: {
  Tauri = {
    userSettings = {
      "javascript.suggest.paths" = false;
      "typescript.suggest.paths" = false;
    };

    extensions = with pkgs.vscode-extensions; [
      vue.volar # Vue LSP
      bradlc.vscode-tailwindcss # Tailwind CSS LSP
      rust-lang.rust-analyzer # Rust LSP
      tauri-apps.tauri-vscode # Tauri LSP

      dbaeumer.vscode-eslint
      esbenp.prettier-vscode
    ];
  };
}
