{pkgs, ...}: let
  baseExtensions = import ../baseExtensions.nix pkgs;
in {
  programs.vscode.profiles."C&C++" = {
    userSettings = {
      "clangd.arguments" = [
        "--all-scopes-completion"
        "--completion-parse=auto"
        "--completion-style=detailed"
        "--background-index"
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
      ++ baseExtensions;
  };
}
