{
  mylib,
  config,
  ...
}: {
  imports = mylib.scanModules ./.;
}
