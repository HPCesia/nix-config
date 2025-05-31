{pkgs, ...}: {
  home.packages = with pkgs; [
    # === Data & Configuration Languages === #
    # -- Nix
    nil # Nix LSP
    alejandra # Nix Code Formatter

    # -- Documents
    marksman # Markdown LSP
    tinymist # Typst LSP
    typstyle # Typst Formatter
  ];
}
