# Host secrets

This folder contains host-specific settings, typically the IP address of a VPS.

## IP Secret Management

Define some common host configuration options in `/modules/base/hosts.nix` and declare them centrally in `/hosts/general.nix`. In `/modules/base/users.nix`, store IP-related secrets in files and import them into `knownHosts`; in `/modules/nixos/base/networking.nix`, store IP-related secrets in systemd's drop-in.