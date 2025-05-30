{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    languagePacks = ["zh-CN" "en-US"];

    policies = {
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
    };

    profiles.default = {
      settings = {};
    };
  };
}
