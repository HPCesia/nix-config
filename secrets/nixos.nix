{
  lib,
  config,
  ...
}:
with lib; let
  cfg = config.modules.secrets;
in {
  imports = [./base.nix];

  options.modules.secrets = {
    mihomo.enable = mkEnableOption "NixOS Secrets for Mihomo";
  };

  config = mkMerge [
    {
      sops.secrets = {
        "aria2-rpc-secret" = {
          restartUnits = ["aria2.service"];
        };
      };
    }

    (mkIf cfg.mihomo.enable {
      sops.secrets = genAttrs [
        "mihomo/providers/yi_yuan"
        "mihomo/providers/mo_jie"
      ] (name: {restartUnits = ["mihomo.service"];});
    })
  ];
}
