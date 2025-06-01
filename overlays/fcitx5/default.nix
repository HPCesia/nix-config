# To use my rime data instead of default rime-data, there needs override.
# Reference: https://github.com/NixOS/nixpkgs/blob/e4246ae1e7f78b7087dce9c9da10d28d3725025f/pkgs/tools/inputmethods/fcitx5/fcitx5-rime.nix
_: (_: super: {
  rime-data = ./rime;
  fcitx5-rime = super.fcitx5-rime.override {rimeDataPkgs = [./rime];};
})
