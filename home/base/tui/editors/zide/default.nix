{
  pkgs,
  nur-hpcesia,
  ...
}: let
  zide = nur-hpcesia.packages.${pkgs.system}.zide.overrideAttrs (oldAttrs: {
    passthru =
      oldAttrs.passthru
      // {
        layoutDir = ./layouts;
        useYaziConfig = false;
      };
  });
in {
  home.packages = [zide];
}
