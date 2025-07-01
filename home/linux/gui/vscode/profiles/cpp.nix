{pkgs, ...}: let
  baseExtensions = import ../baseExtensions.nix pkgs;
in {
  programs.vscode.profiles."C++" = {
    userSettings = {
      "clangd.arguments" = [
        "--compile-commands-dir=\${workspaceFolder}/.vscode"
        "--all-scopes-completion"
        "--completion-parse=auto"
        "--completion-style=detailed"
        "--background-index"
        "--pch-storage=memory"
        "--clang-tidy"
        "--fallback-style=LLVM"
      ];
      "clangd.checkUpdates" = false;
      "editor.suggest.snippetsPreventQuickSuggestions" = false;
      "lldb.dereferencePointers" = true;
      "lldb.evaluateForHovers" = true;
    };

    extensions =
      (with pkgs.vscode-extensions; [
        llvm-vs-code-extensions.vscode-clangd
        vadimcn.vscode-lldb
      ])
      ++ (
        pkgs.vscode-utils.extensionsFromVscodeMarketplace [
          {
            name = "xmake-vscode";
            publisher = "tboox";
            version = "2.4.0";
            sha256 = "rxx/tG0WqSQoP1nfuknPewDkmEkNBkFBaC2ZrWwTLpg=";
          }
        ]
      )
      ++ baseExtensions;
  };
}
