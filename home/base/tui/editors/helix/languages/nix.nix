{...}: {
  programs.helix.languages = {
    language = [
      {
        name = "nix";
        auto-format = true;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        language-servers = ["nil"];
      }
    ];
    language-server = {
      nil.config.nil = {
        formatting.command = ["alejandra"];
        nix = {
          maxMemoryMB = 4096;
          flake = {
            autoArchive = false;
            autoEvalInputs = true;
          };
        };
      };
    };
  };
}
