{
  lib,
  pkgs,
  ...
}: {
  # Lid Settings
  services.logind = {
    lidSwitch = "hibernate";
    lidSwitchExternalPower = "lock";
    lidSwitchDocked = "ignore";
  };

  # Fingerprint
  services.fprintd = {
    enable = true;
    tod = {
      enable = true;
      driver = pkgs.libfprint-2-tod1-goodix;
    };
  };
  systemd.services.fprintd = {
    wantedBy = ["multi-user.target"];
    serviceConfig.Type = "simple";
  };

  # Cooling management
  services.thermald.enable = lib.mkDefault true;

  # Touchpad
  services.libinput.enable = true;

  # √(3200² + 2000²) px / 16 in ≃ 235 dpi
  services.xserver.dpi = 235;

  # Mihomo
  services.mihomo.enable = true;
}
