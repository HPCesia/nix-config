{
  nixos-hardware,
  config,
  lib,
  ...
}: let
  nvidiaPackage = config.hardware.nvidia.package; # Nvidia ada lovelace
in {
  imports = [
    nixos-hardware.nixosModules.common-gpu-nvidia
  ];

  services.xserver.videoDrivers = ["nvidia" "modesetting"]; # will install nvidia-vaapi-driver by default
  boot.initrd.kernelModules = ["nvidia"];
  boot.extraModulePackages = [config.boot.kernelPackages.nvidia_x11];
  boot.kernelParams = ["nvidia-drm.modeset=1"];

  # Nvidia ada lovelace
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    prime = {
      intelBusId = "PCI:00:02:0";
      nvidiaBusId = "PCI:01:00:0";
    };
    open = lib.mkOverride 990 (nvidiaPackage ? open && nvidiaPackage ? firmware);
  };

  hardware.nvidia-container-toolkit.enable = true;
  hardware.graphics = {
    enable = true;
    # needed by nvidia-docker
    enable32Bit = true;
  };

  nixpkgs.config.cudaSupport = true;
}
