{
  pkgs,
  myvars,
  ...
}: {
  environment.variables.EDITOR = "hx";
  environment.systemPackages = with pkgs; [
    fastfetch
    helix
    micro
    nushell
    git

    # archives
    zip
    xz
    zstd
    unzipNLS
    p7zip
    gnutar

    # networking tools
    wget
    curl

    # misc
    file
    tree
  ];

  users.users.${myvars.username} = {
    description = myvars.userfullname;
  };

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = [myvars.username];
    substituters = [
      # cache mirror located in China
      # "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"

      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    builders-use-substitutes = true;
  };
}
