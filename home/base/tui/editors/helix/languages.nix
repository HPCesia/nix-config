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
      {
        name = "typst";
        auto-format = true;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        formatter = {command = "typstyle";};
      }
    ];
    language-server = {
      nil.config = {
          formatting.command = "alejandra";
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
