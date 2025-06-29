{pkgs, ...}: let
  baseExtensions = import ../baseExtensions.nix pkgs;
in {
  programs.vscode.profiles.Typst = {
    userSettings = {
      "tinymist.formatterMode" = "typstyle";
      "[typst-code]"."editor.wordSeparators" = "`~!@#$%^&*()=+[{]}\\|;:'\",.<>/?";
      "[typst]"."editor.unicodeHighlight.ambiguousCharacters" = false;
    };

    extensions =
      (with pkgs.vscode-extensions; [
        myriad-dreamin.tinymist # Typst LSP
        tomoki1207.pdf # PDF Viewer
      ])
      ++ baseExtensions;
  };
}
