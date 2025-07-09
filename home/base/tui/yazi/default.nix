{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    plugins = {
      git = pkgs.yaziPlugins.git;
      starship = pkgs.yaziPlugins.starship;
      auto-layout = ./plugins/auto-layout.yazi;
    };
    initLua = ''
      require("git"):setup()
      require("starship"):setup()
      require("auto-layout").setup()
    '';
    settings = {
      mgr = {
        show_hidden = true;
        sort_dir_first = true;
      };
      plugin.prepend_fetchers = [
        {
          id = "git";
          name = "*";
          run = "git";
        }
        {
          id = "git";
          name = "*/";
          run = "git";
        }
      ];
    };
  };
}
