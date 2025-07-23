{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # system tools
    dmidecode
    efibootmgr
    ethtool
  ];
}
