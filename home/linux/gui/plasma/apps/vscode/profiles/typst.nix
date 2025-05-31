{pkgs, ...}: let
  baseExtensions = import ../baseExtensions.nix pkgs;
in {
  programs.vscode.profiles.typst = {
    userSettings = {
      "tinymist.formatterMode" = "typstyle";
      "[typst-code]"."editor.wordSeparators" = "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?";
      "[typst]"."editor.unicodeHighlight.ambiguousCharacters" = false;
    };

    extensions =
      (with pkgs.vscode-extensions; [
        myriad-dreamin.tinymist # Typst LSP
        tamasfe.even-better-toml # TOML syntax
        tomoki1207.pdf # PDF Viewer
      ])
      ++ baseExtensions;
  };
}
