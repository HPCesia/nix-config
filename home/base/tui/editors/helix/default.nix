{
  lib,
  pkgs-unstable,
  ...
}: {
  imports = [./languages];

  programs.helix = {
    package = lib.mkDefault pkgs-unstable.helix;
    settings = {
      editor = {
        line-number = "relative";
        cursorline = true;
        bufferline = "multiple";
        color-modes = true;
        trim-trailing-whitespace = true;
        inline-diagnostics.cursor-line = "warning";
        end-of-line-diagnostics = "error";
        lsp = {
          display-inlay-hints = true;
          inlay-hints-length-limit = 16;
        };
        indent-guides = {
          render = true;
          character = "┊";
          skip-levels = 1;
        };
      };
    };
  };
}
