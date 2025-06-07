{pkgs, ...}: {
  programs.firefox = {
    enable = true;
    languagePacks = ["zh-CN" "en-US"];

    policies = {
      DisableAppUpdate = true;
      DisablePocket = true;
      DisableSetDesktopBackground = true;
      DisableTelemetry = true;
      DontCheckDefaultBrowser = true;
      ExtensionUpdate = false;
      NoDefaultBookmarks = true;
      OfferToSaveLogins = false;
      PasswordManagerEnabled = false;
    };

    profiles.default = {
      id = 0;
      isDefault = true;
      search = {
        force = true;
        default = "bing";
        privateDefault = "duckduckgo";
        order = [
          "bing"
          "google"
          "duckduckgo"
        ];
        engines = {
          baidu.metaData.hidden = true;
        };
      };
      extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
        ublock-origin
        bitwarden
        tampermonkey
        rsshub-radar
        auto-tab-discard
      ];
      settings = {
        # No First Run
        "app.normandy.first_run" = false;
        "doh-rollout.doneFirstRun" = true;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "trailhead.firstrun.didSeeAboutWelcome" = true;
        "browser.toolbarbuttons.introduced.sidebar-button" = true;
        "sidebar.old-sidebar.has-used" = true;
        "sidebar.new-sidebar.has-used" = true;
        # Language
        "general.useragent.locale" = "zh-CN";
        "intl.locale.requested" = "zh-CN,en-US";
        "browser.translations.mostRecentTargetLanguages" = "zh-Hans";
        # No Ads
        "browser.urlbar.suggest.topsites" = false;
        "browser.urlbar.suggest.trending" = false;
        "browser.newtabpage.pinned" = [];
        "browser.newtabpage.activity-stream.showSponsored" = false;
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        # General
        "browser.startup.page" = 3; # Open prev session pages
        "browser.tabs.unloadOnLowMemory" = true;
        # Apperance
        "browser.newtabpage.activity-stream.feeds.topsites" = false;
        "browser.newtabpage.activity-stream.default.sites" = "";
        "browser.toolbars.bookmarks.visibility" = "always";
        "sidebar.verticalTabs" = true;
        "sidebar.main.tools" = "syncedtabs";
        "sidebar.visibility" = "expand-on-hover";
        "browser.uiCustomization.state" = {
          "placements" = {
            "widget-overflow-fixed-list" = [];
            "unified-extensions-area" = [];
            "nav-bar" = [
              "sidebar-button"
              "back-button"
              "forward-button"
              "stop-reload-button"
              "vertical-spacer"
              "customizableui-special-spring7"
              "urlbar-container"
              "customizableui-special-spring2"
              "unified-extensions-button"
              "fxa-toolbar-menu-button"
            ];
            "toolbar-menubar" = ["menubar-items"];
            "TabsToolbar" = [];
            "vertical-tabs" = ["tabbrowser-tabs"];
            "PersonalToolbar" = ["personal-bookmarks"];
          };
          "seen" = ["developer-button"];
          "dirtyAreaCache" = [];
        };
        # Disable Telemetry
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "data:,";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "toolkit.telemetry.shutdownPingSender.enabledFirstsession" = false;
        "browser.ping-centre.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
      };
    };
  };
}
