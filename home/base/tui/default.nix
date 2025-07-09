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

  catppuccin.flavor = "macchiato";
}
