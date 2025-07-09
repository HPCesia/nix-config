{
  mylib,
  catppuccin,
  ...
}: {
  imports =
    (mylib.scanModules ./.)
    ++ [
      catppuccin.homeModules.catppuccin
    ];

  catppuccin = {
    enable = true;
    flavor = "macchiato";
  };
}
