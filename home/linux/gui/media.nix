{pkgs, ...}: {
  home.packages = with pkgs; [
    quodlibet-full
    musikcube
  ];
}
