{pkgs, ...}: {
  Rust = {
    userSettings = {
    };

    extensions = with pkgs.vscode-extensions; [
      rust-lang.rust-analyzer
      vadimcn.vscode-lldb
    ];
  };
}
