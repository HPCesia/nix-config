{
  pkgs,
  myvars,
  config,
  ...
}: {
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

  services.aria2 = {
    enable = true;
    rpcSecretFile = config.sops.secrets.aria2-rpc-secret.path;
    settings = {
      enable-rpc = true;
      rpc-listen-port = 6800;
    };
  };

  users.users.${myvars.username} = {
    description = myvars.userfullname;
  };

  sops.templates.access-tokens = {
    content = ''
      access-tokens = github.com=${config.sops.placeholder.github-access-token}
    '';
    mode = "0444"; # file must be accessible (r) to all users, because only the build daemon runs as root and not nix evaluator itself.
  };

  nix.extraOptions = ''
    !include ${config.sops.templates.access-tokens.path}
  '';

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
