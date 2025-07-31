{pkgs, ...}: {
  programs.gh = {
    enable = true;
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
    };
    hosts = {
      "github.com" = {
        user = "HPCesia";
      };
    };
    extensions = with pkgs; [
      gh-copilot
    ];
  };
}
