{pkgs, ...}: let
  baseExtensions = import ../baseExtensions.nix pkgs;
in {
  programs.vscode.profiles.Rust = {
    userSettings = {
    };

    extensions =
      (with pkgs.vscode-extensions; [
        rust-lang.rust-analyzer
        vadimcn.vscode-lldb
      ])
      ++ baseExtensions;
  };
}
