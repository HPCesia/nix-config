{
  lib,
  config,
  myvars,
  sops-nix,
  ...
}: {
  imports =
    [
      sops-nix.nixosModules.sops
      ./hosts
    ]
    ++ (
      builtins.map (k: {
        sops.secrets."rclone-${k}" =
          lib.mkIf
          config.home-manager.users.${myvars.username}.programs.rclone.enable
          {
            key = "rclone/${k}";
            owner = myvars.username;
          };
      }) ["onedrive-token" "restic-backup-token"]
    );

  sops.age = {
    sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    generateKey = true;
  };

  sops.defaultSopsFile = ./secrets.yaml;

  sops.secrets."github-access-token" = {};
}
