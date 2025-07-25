{pkgs, ...}: {
  home.packages = with pkgs; [
    geogebra
    wireshark # network analyzer
  ];
}
