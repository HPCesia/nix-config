{
  lib,
  myvars,
  config,
  ...
}: let
  hosts = config.modules.my-hosts;
  sshTargetHosts = lib.filterAttrs (n: v: !builtins.isNull v.hostPublicKey) hosts;
in {
  programs.ssh = {
    extraConfig =
      lib.attrsets.foldlAttrs
      (acc: host: val:
        acc
        + ''
          Host ${host}
            HostName ${val.network.ipv4}
            Port ${val.sshPort}
        '')
      ""
      sshTargetHosts;
    knownHosts =
      lib.mapAttrs'
      (
        host: value:
          lib.attrsets.nameValuePair
          (value.network.ipv4)
          {
            inherit (value) hostPublicKey;
            hostNames = [host];
          }
      )
      sshTargetHosts;
  };

  users.users.${myvars.username} = {
    description = myvars.userfullname;
    openssh.authorizedKeys.keys = myvars.sshAuthorizedKeys;
  };
}
