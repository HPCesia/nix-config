{
  lib,
  myvars,
  config,
  ...
}: let
  hosts = config.modules.my-hosts;
  managedHosts =
    lib.filterAttrs (
      name: host:
        !builtins.isNull host.hostPublicKey
        && (!builtins.isNull host.network.ipv4 || !builtins.isNull host.network.ipv6)
    )
    hosts;
  secretIpHosts =
    lib.filterAttrs (
      name: host:
        isSecret host.network.ipv4 || isSecret host.network.ipv6
    )
    managedHosts;

  isSecret = v: lib.isAttrs v && v ? "secretName";
  isPlain = v: lib.isString v;
in {
  users.users.${myvars.username} = {
    description = myvars.userfullname;
    openssh.authorizedKeys.keys = myvars.sshAuthorizedKeys;
  };

  programs.mosh.enable = true; # Alternative of SSH for high latency connections
  programs.ssh.knownHosts =
    lib.mapAttrs'
    (name: host: lib.nameValuePair name {publicKey = host.hostPublicKey;})
    managedHosts;

  programs.ssh.extraConfig = ''
    ${lib.concatStringsSep "\n" (
      lib.mapAttrsToList (
        name: host: let
          cfg = host.network;
        in ''
          Host ${name}
            ${lib.optionalString (isPlain cfg.ipv4) "HostName ${cfg.ipv4}"}
            ${lib.optionalString (isPlain cfg.ipv6) "HostName ${cfg.ipv6}"}
            ${
            lib.optionalString (isSecret cfg.ipv4 || isSecret cfg.ipv6)
            "Include ${config.sops.templates."ssh-config-${name}".path}"
          }
            Port ${toString (lib.elemAt host.sshPorts 0)}
        ''
      )
      managedHosts
    )}
  '';

  sops.templates =
    lib.mapAttrs'
    (name: host:
      lib.nameValuePair "ssh-config-${name}" {
        content = ''
          ${lib.optionalString (isSecret host.network.ipv4) ''
            HostName ${config.sops.placeholder.${host.network.ipv4.secretName}}
          ''}
          ${lib.optionalString (isSecret host.network.ipv6) ''
            HostName ${config.sops.placeholder.${host.network.ipv6.secretName}}
          ''}
        '';
        owner = "root";
        group = "ssh-secrets-users";
        mode = "0440";
      })
    secretIpHosts;
}
