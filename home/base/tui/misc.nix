{
  pkgs,
  pkgs-unstable,
  colmena,
  ...
}: {
  home.packages = with pkgs; [
    colmena.packages.${system}.colmena # nixos's remote deployment tool
  ];

  programs.btop.enable = true;
}
