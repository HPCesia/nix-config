{pkgs, ...}: {
  home.packages = with pkgs.kdePackages; [
    kdenlive
  ];

  services.kdeconnect = {
    enable = true;
    indicator = true;
  };
}
