{
  pkgs,
  pkgs-unstable,
  colmena,
  ...
}: {
  home.packages = with pkgs; [
    # Database
    pkgs-unstable.mycli
    pkgs-unstable.pgcli
    sqlite

    colmena.packages.${system}.colmena # nixos's remote deployment tool
  ];

  programs.btop.enable = true;
}
