{
  pkgs,
  pkgs-unstable,
  ...
}: let
  lyricbar = pkgs.stdenv.mkDerivation {
    pname = "deadbeef-lyricbar-plugin-modified";
    version = "unstable-2024-10-24";
    src = pkgs.fetchFromGitHub {
      owner = "wind-mask";
      repo = "deadbeef-lyricbar";
      rev = "b28f9c9cafd9200db8fb8f0639ab44d23042bc39";
      sha256 = "Nho9aF6SiqtkdIgXQ0FCM89wGM9VFIA25sfIffHIoZ8=";
    };
    nativeBuildInputs = [pkgs.pkg-config];
    buildInputs = with pkgs; [
      deadbeef
      gtkmm3
      curl
      taglib_1
    ];
    NIX_CFLAGS_COMPILE = "-Wno-incompatible-pointer-types";
    buildFlags = ["gtk3"];
  };
in {
  programs.deadbeef = {
    enable = true;
    package = pkgs-unstable.deadbeef-with-plugins;
    plugins = with pkgs-unstable.deadbeefPlugins; [
      mpris2
      lyricbar
    ];
    settings = {
      close_send_to_tray = 1;
      "gtkui.override_bar_colors" = 1;
      "lyricbar.backgroundcolor" = "#24273a";
      "lyricbar.highlightcolor" = "#c6a0f6";
      "lyricbar.regularcolor" = "#cad3f5";
      "junk.enable_cp936_detection" = 1;
      gtkui.layout = {
        type = "hsplitter";
        legacy_params = " locked=2 ratio=0.76 pos=0 size2=360";
        children = [
          {
            type = "vbox";
            legacy_params = " expand=\"1 0\" fill=\"1 1\" homogeneous=0";
            children = [
              {
                type = "hsplitter";
                legacy_params = " locked=0 ratio=0.25 pos=0 size2=0";
                children = [
                  {
                    type = "vsplitter";
                    legacy_params = " locked=0 ratio=0.5 pos=0 size2=0";
                    children = [
                      {type = "medialibviewer";}
                      {type = "pltbrowser";}
                    ];
                  }
                  {
                    type = "playlist";
                    legacy_params = " hideheaders=0 width=604";
                  }
                ];
              }
              {
                type = "hbox";
                legacy_params = " expand=\"0 1 0\" fill=\"0 1 0\" homogeneous=0";
                children = [
                  {type = "playtb";}
                  {type = "seekbar";}
                  {
                    type = "volumebar";
                    settings = {
                      scale = "db";
                    };
                  }
                ];
              }
            ];
          }
          {
            type = "vsplitter";
            legacy_params = " locked=2 ratio=0.9 pos=0 size2=90";
            children = [
              {
                type = "vsplitter";
                legacy_params = " locked=1 ratio=0.48 pos=360 size2=0";
                children = [
                  {
                    type = "coverart";
                    settings.mode = "selected";
                  }
                  {type = "lyricbar";}
                ];
              }
              {
                type = "spectrum";
                settings = {
                  renderMode = "bands";
                  distanceBetweenBars = "3";
                  barGranularity = "2";
                };
              }
            ];
          }
        ];
      };
      gtkui.columns.playlist = [
        {
          title = "♫";
          id = "1";
          format = "%playstatus%";
          sort_format = "";
          size = "50";
          align = "0";
          color_override = "0";
          color = "#ff000000";
        }
        {
          title = "艺人 / 专辑";
          id = "-1";
          format = "$if(%artist%,%artist%,Unknown Artist)[ - %album%]";
          sort_format = "";
          size = "138";
          align = "0";
          color_override = "0";
          color = "#ff000000";
        }
        {
          title = "标题";
          id = "-1";
          format = "%title%";
          sort_format = "";
          size = "150";
          align = "0";
          color_override = "0";
          color = "#ff000000";
        }
        {
          title = "音轨号";
          id = "-1";
          format = "%tracknumber%";
          sort_format = "";
          size = "65";
          align = "1";
          color_override = "0";
          color = "#ff000000";
        }
        {
          title = "时长";
          id = "-1";
          format = "%length%";
          sort_format = "";
          size = "50";
          align = "0";
          color_override = "0";
          color = "#ff000000";
        }
      ];
    };
  };
}
