{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs; [
    geogebra
    wireshark # network analyzer

    pkgs-unstable.readest # ebook reader
  ];

  programs.rbw.settings.pinentry = pkgs.pinentry-qt;
}
