{...}: {
  programs.helix.languages = {
    language = [
      {
        name = "typescript";
        auto-format = true;
        indent = {
          tab-width = 2;
          unit = "  ";
        };
        formatter = {
          command = "prettier";
          args = ["--stdin-filepath %{buffer_name}"];
        };
      }
    ];
  };
}
