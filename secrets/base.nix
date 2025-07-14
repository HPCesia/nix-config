{sops-nix, ...}: {
  imports = [
    sops-nix.nixosModules.sops
    ./hosts
  ];

  sops.defaultSopsFile = ./secrets.yaml;

  sops.secrets."github-access-token" = {};

  sops.age = {
    sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    generateKey = true;
  };
}
