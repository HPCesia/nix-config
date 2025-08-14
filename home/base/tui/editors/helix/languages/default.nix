{mylib, ...}: {
  imports = mylib.scanModules ./.;

  programs.helix.languages.language-server = {
    helix-gpt.command = "helix-gpt";
  };
}
