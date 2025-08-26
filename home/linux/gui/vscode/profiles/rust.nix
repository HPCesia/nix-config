{
  pkgs,
  lib,
  ...
}: {
  Rust = {
    userSettings = {
      "rust-analyzer.server.path" = lib.getExe pkgs.rust-analyzer;
    };

    extensions = with pkgs.vscode-extensions; [
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb
    ];
  };
}
