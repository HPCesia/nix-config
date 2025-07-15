{
  config,
  lib,
  ...
}: {
  boot.kernelParams = [
    "audit=0"
    "net.ifnames=0"
  ];

  boot.initrd = {
    compressor = "zstd";
    compressorArgs = ["-19" "-T0"];
    availableKernelModules = ["virtio_blk" "virtio_pci" "virtio_scsi"];
    systemd.enable = true;
  };

  boot.loader.grub = {
    enable = true;
    default = "saved";
    # Force solve mirroredBoots error
    # See https://github.com/nix-community/disko/issues/1068#issuecomment-2974926079
    devices = lib.mkForce ["/dev/vda"];
  };
}
