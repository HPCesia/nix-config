{pkgs, ...}: {
  environment.variables.EDITOR = "hx";
  environment.systemPackages = with pkgs; [
    fastfetch
    helix
    nushell
    git

    # archives
    zip
    xz
    zstd
    unzipNLS
    p7zip
    gnutar

    # text processing
    gnugrep
    gnused
    gawk
    jq

    # networking tools
    wget
    curl

    # misc
    file
    tree
    which
    findutils
  ];

  services.aria2.enable = true;
}
