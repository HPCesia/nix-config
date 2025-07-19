{
  lib,
  config,
  ...
}: {
  imports = [./base.nix];

  config = lib.mkMerge [
    {
      sops.secrets = {
        "aria2-rpc-secret" = {
          restartUnits = ["aria2.service"];
        };
      };
    }

    (lib.mkIf config.services.mihomo.enable {
      sops.secrets = lib.genAttrs [
        "mihomo/providers/yi_yuan"
        "mihomo/providers/mo_jie"
      ] (name: {restartUnits = ["mihomo.service"];});
    })
  ];
}
