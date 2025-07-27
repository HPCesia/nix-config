{
  pkgs,
  pkgs-unstable,
  lib,
  ...
}: let
  audacious-wrapped = let
    p = pkgs-unstable.audacious;
  in
    lib.hiPrio (
      pkgs.runCommand "${p.name}-wrapped" {nativeBuildInputs = with pkgs; [makeWrapper];} ''
        mkdir -p $out/bin
        makeWrapper \
          ${p}/bin/${p.meta.mainProgram or p.pname} \
          $out/bin/${p.meta.mainProgram or p.pname} \
          --set GTK_IM_MODULE wayland \
          --set QT_IM_MODULE fcitx
      ''
    );
in {
  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      scripts = [pkgs.mpvScripts.mpris];
    };
  };

  home.packages = with pkgs; [
    audacious-wrapped
  ];
}
