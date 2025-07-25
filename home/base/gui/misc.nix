{pkgs, ...}: {
  home.packages = with pkgs; [
    geogebra
    wireshark # network analyzer
  ];

  programs.rbw.settings.pinentry = pkgs.pinentry-qt;
}
