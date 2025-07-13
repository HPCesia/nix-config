{sops-nix, ...}: {
  imports = [
    sops-nix.nixosModules.sops
    ./base
    ./nixos
  ];

  sops.age = {
    sshKeyPaths = ["/etc/ssh/ssh_host_ed25519_key"];
    generateKey = true;
  };
}
