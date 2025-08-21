{
  pkgs,
  lib,
  config,
  ...
}: {
  services.gitea-actions-runner = {
    package = pkgs.forgejo-runner;
    instances.default = {
      enable = true;
      name = "runner-pardofelis";
      url = "https://repo.hpcesia.com/";
      tokenFile = config.sops.templates."forgejo-runner-token-file".path;
      labels = [
        "ubuntu-22.04:docker://ghcr.io/catthehacker/ubuntu:act-22.04"
        "nixos-latest:host"
      ];
      settings = {
        container = {
          network = "bridge";
          enable_ipv6 = true;
        };
      };
      hostPackages = with pkgs; [
        bash
        coreutils
        curl
        gawk
        gitMinimal
        gnused
        nodejs
        wget
        nix
      ];
    };
  };

  users.users.gitea-runner = {
    isSystemUser = true;
    useDefaultShell = true;
    group = "gitea-runner";
  };
  users.groups.gitea-runner = {};

  sops.templates.forgejo-runner-token-file = {
    content = "TOKEN=${config.sops.placeholder.forgejo-runner-token}";
    owner = "root";
    group = "gitea-runner";
    mode = "0440";
  };

  systemd.services.gitea-runner-default.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "gitea-runner";
    Group = "gitea-runner";
  };

  # If you would like to use docker runners in combination with cache actions,
  # be sure to add docker bridge interfaces “br-*” to the firewalls’ trusted interfaces.
  # See https://forgejo.org/docs/next/admin/actions/runner-installation/#nixos
  networking.firewall.trustedInterfaces = ["br-+"];
}
