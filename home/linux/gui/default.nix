{
  mylib,
  catppuccin,
  ...
}: {
  imports =
    (mylib.scanPaths ./.)
    ++ [catppuccin.homeModules.catppuccin];

  catppuccin.flavor = "macchiato";
}
