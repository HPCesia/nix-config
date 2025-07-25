{
  pkgs,
  config,
  myvars,
  programsdb,
  ...
}: {
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    trusted-users = [myvars.username];
    substituters = [
      # cache mirror located in China
      # "https://mirrors.ustc.edu.cn/nix-channels/store"
      # "https://mirror.sjtu.edu.cn/nix-channels/store"
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"

      "https://nix-community.cachix.org"
    ];
    trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "colmena.cachix.org-1:7BzpDnjjH8ki2CT3f6GdOk7QAzPOl+1t3LvTLXqYcSg="
    ];
    builders-use-substitutes = true;
  };

  nix.extraOptions = ''
    !include ${config.sops.templates.access-tokens.path}
  '';

  sops.templates.access-tokens = {
    content = ''
      access-tokens = github.com=${config.sops.placeholder.github-access-token}
    '';
    mode = "0444"; # file must be accessible (r) to all users, because only the build daemon runs as root and not nix evaluator itself.
  };

  environment.etc."programs.sqlite".source = programsdb.packages.${pkgs.system}.programs-sqlite;
  programs.command-not-found.dbPath = "/etc/programs.sqlite";
}
