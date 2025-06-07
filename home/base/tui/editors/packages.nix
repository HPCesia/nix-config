{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs; [
    # === Data & Configuration Languages === #
    # -- Nix
    nil # Nix LSP
    alejandra # Nix Code Formatter

    # -- Json Like
    taplo # TOML LSP / formatter / validator
    nodePackages.yaml-language-server
    actionlint # GitHub Actions linter

    # -- Documents
    marksman # Markdown LSP
    tinymist # Typst LSP
    typstyle # Typst Formatter

    # === General Purpose Languages === #
    # -- C/C++
    cmake
    cmake-language-server
    gnumake
    checkmake
    xmake
    gcc
    gdb
    clang-tools
    lldb

    # -- Python
    uv # Python package manager in rust
    pixi # Python package manager in rust, supports conda
    ruff # Python LSP and formatter
    python313

    #-- rust
    pkgs-unstable.rustc
    pkgs-unstable.rust-analyzer
    pkgs-unstable.cargo # rust package manager
    pkgs-unstable.rustfmt
    pkgs-unstable.clippy # rust linter

    # -- Lua
    stylua
    lua-language-server

    #-- bash
    nodePackages.bash-language-server
    shellcheck
    shfmt

    # === Web Development === #
    nodePackages.nodejs
    pnpm
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.vscode-langservers-extracted # HTML/CSS/JSON/ESLint LSP extracted from vscode
    nodePackages."@tailwindcss/language-server"
    nodePackages."@astrojs/language-server"
  ];
}
