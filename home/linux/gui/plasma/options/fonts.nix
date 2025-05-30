{...}: {
  # Fonts used here should be added to
  # [flakeRoot]/modules/nixos/desktop/fonts.nix
  programs.plasma.fonts = {
    general = {
      family = "Source Han Sans SC";
      pointSize = 11;
    };
    fixedWidth = {
      family = "Maple Mono NF CN";
      pointSize = 11;
    };
    menu = {
      family = "Source Han Sans SC";
      pointSize = 11;
    };
    small = {
      family = "Source Han Sans SC";
      pointSize = 9;
    };
    toolbar = {
      family = "Source Han Sans SC";
      pointSize = 11;
    };
    windowTitle = {
      family = "Source Han Sans SC";
      pointSize = 11;
    };
  };
}
