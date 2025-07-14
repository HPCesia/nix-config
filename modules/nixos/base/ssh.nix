{
  lib,
  config,
  hostName,
  ...
}: {
  # Or disable the firewall altogether.
  networking.firewall.enable = lib.mkDefault false;
  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    ports = config.modules.my-hosts.${hostName}.sshPorts;
    settings = {
      # root user is used for remote deployment.
      PermitRootLogin = "prohibit-password";
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };

  # Add terminfo database of all known terminals to the system profile.
  # https://github.com/NixOS/nixpkgs/blob/nixos-25.05/nixos/modules/config/terminfo.nix
  environment.enableAllTerminfo = true;
}
