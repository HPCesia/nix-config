{
  pkgs,
  config,
  lib,
  myvars,
  ...
}: let
  getThunderbirdAccountPath = accountName: profileName: let
    accountId = builtins.hashString "sha256" accountName;
    thunderbirdProfilesPath = ".thunderbird";
  in "${config.home.homeDirectory}/${thunderbirdProfilesPath}/${profileName}/ImapMail/${accountId}";
  thunderbird-x = pkgs.thunderbird.overrideAttrs (oldAttrs: {
    makeWrapperArgs = oldAttrs.makeWrapperArgs ++ ["--set" "MOZ_ENABLE_WAYLAND" "0"];
  });
in {
  programs.thunderbird = {
    enable = true;
    package = thunderbird-x;
    profiles.Default = {
      isDefault = true;
      settings = {
        "extensions.autoDisableScopes" = 0;
      };
    };
  };

  catppuccin.thunderbird.profile = "Default";

  accounts.email.accounts = {
    "${myvars.useremail}".thunderbird.enable = true;
    "hpcesia@outlook.com".thunderbird.enable = true;
  };

  home.packages = with pkgs; [
    birdtray
  ];

  xdg.configFile."birdtray-config.json" = {
    force = true;
    text = builtins.toJSON (
      (builtins.fromJSON (builtins.readFile ./birdtray-default-config.json))
      // {
        accounts =
          lib.mapAttrsToList (n: v: {
            path = "${getThunderbirdAccountPath v.name "Default"}/INBOX.msf";
          })
          (lib.filterAttrs (n: v: v.thunderbird.enable) config.accounts.email.accounts);
      }
      // (lib.mapAttrs' (n: v: lib.nameValuePair "common/${n}" v) {
        launchthunderbird = true;
        exitthunderbirdonquit = true;
        defaultcolor = "#c6a0f6"; # Catppucin Macchiato Mauve
        hideWhenStartedManually = false;
        hidewhenminimized = true;
        hidewhenrestarted = true;
        hidewhenstarted = true;
        showhidethunderbird = true;
      })
      // (lib.mapAttrs' (n: v: lib.nameValuePair "advanced/${n}" v) {
        tbcmdline = [(lib.getExe thunderbird-x)];
        tbwindowmatch = "Thunderbird";
        updateOnStartup = false;
        unreadopacitylevel = 0.80;
      })
    );
  };
}
