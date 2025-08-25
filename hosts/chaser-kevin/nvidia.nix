{
  config,
  lib,
  ...
}: {
  services.xserver.videoDrivers = ["nvidia" "modesetting"]; # will install nvidia-vaapi-driver by default
  boot.initrd.kernelModules = ["nvidia"];
  boot.extraModulePackages = [config.boot.kernelPackages.nvidia_x11];
  boot.kernelParams = ["nvidia-drm.modeset=1"];

  # Nvidia ada lovelace
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.production;
    open = false;
    modesetting.enable = true;
    prime = {
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
      offload = {
        enable = true;
        enableOffloadCmd = lib.mkIf config.hardware.nvidia.prime.offload.enable true;
      };
    };
  };

  hardware.nvidia-container-toolkit.enable = true;
  hardware.graphics = {
    enable = true;
    # needed by nvidia-docker
    enable32Bit = true;
  };

  nixpkgs.config.cudaSupport = true;
}
