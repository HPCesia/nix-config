{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs; [
    geogebra
    pkgs-unstable.readest # ebook reader
    rnote
    inkscape

    wireshark # network analyzer

    veracrypt
  ];

  programs.rbw.settings.pinentry = pkgs.pinentry-qt;
}
