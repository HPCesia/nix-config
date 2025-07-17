{lib, ...}: let
  mapHomepageConf = attrs: lib.mapAttrsToList (n: v: {${n} = v;}) attrs;
in {
  services.homepage-dashboard = {
    enable = true;
    listenPort = 4982;
    openFirewall = false;
    allowedHosts = "home.hpcesia.com";
    settings = {
      # Basic Infomations
      title = "主页";
      subtitle = "HPCesia";
      description = "HPCesia 的导航板";
      favicon = "https://blog.hpcesia.com/favicon.svg";
      language = "zh-CN";
      startUrl = "https://home.hpcesia.com";
      base = "https://home.hpcesia.com";

      # Appearance
      background = {
        image = "https://bu.dusays.com/2024/11/18/673ac3b7d597c.webp";
        brightness = 75;
        opacity = 75;
      };
      cardBlur = "sm";
      theme = "dark";
      color = "lime";
      statusStyle = "dot";
      headerStyle = "clean";
      iconStyle = "flat";
      useEqualHeights = true;
    };
    widgets = mapHomepageConf {
      resources = {
        cpu = true;
        memory = true;
        disk = "/";
        uptime = true;
      };
      datetime = {
        text_size = "2xl";
        locale = "zh-CN";
        format = {
          dateStyle = "short";
          timeStyle = "short";
        };
      };
    };
  };

  services.homepage-dashboard.settings.layout = mapHomepageConf {
    "开发" = {
      style = "row";
      columns = 3;
      tab = "Home";
    };
    NestedGroup-1 = {
      header = false;
      style = "row";
      columns = 2;
      "工具" = {
        style = "column";
        tab = "Home";
      };
      "阅读" = {
        style = "column";
        tab = "Home";
      };
    };
  };

  services.homepage-dashboard.services = mapHomepageConf {
    "开发" = mapHomepageConf {
      GitHub = {
        href = "https://github.com/";
        icon = "github.svg";
      };
      Codeberg = {
        href = "https://codeberg.org/";
        icon = "codeberg.svg";
      };
      Forgejo = {
        href = "https://repo.hpcesia.com/";
        icon = "forgejo.svg";
        siteMonitor = "https://repo.hpcesia.com/";
      };
      Cloudflare = {
        href = "https://dash.cloudflare.com/";
        icon = "cloudflare.svg";
      };
      Netlify = {
        href = "https://app.netlify.com/";
        icon = "netlify.svg";
      };
      Grafana = {
        href = "https://grafana.hpcesia.com/";
        icon = "grafana.svg";
        siteMonitor = "https://grafana.hpcesia.com/";
      };
    };
    "工具" = mapHomepageConf {
      Vaultwarden = {
        href = "https://bitwarden.hpcesia.com/";
        icon = "vaultwarden.svg";
        siteMonitor = "https://bitwarden.hpcesia.com/";
      };
      Hoppscotch = {
        href = "https://hoppscotch.io/";
        icon = "hoppscotch.svg";
      };
      Squoosh = {
        href = "https://squoosh.app/";
        icon = "sh-squoosh.svg";
      };
    };
    "阅读" = mapHomepageConf {
      FreshRSS = {
        href = "https://rss.hpcesia.com/";
        icon = "freshrss.svg";
        siteMonitor = "https://rss.hpcesia.com/";
      };
      Trinnon = {
        href = "https://trin.one/";
        icon = "https://trin.one/fileserver/01H6611F79D6TD4PCS5YVHWFJZ/attachment/original/01JVQEQBVWB6EXGQ5WGR823C5Y.png";
        siteMonitor = "https://trin.one/";
      };
      Blog = {
        href = "https://blog.hpcesia.com/";
        icon = "https://blog.hpcesia.com/favicon.svg";
        siteMonitor = "https://blog.hpcesia.com/";
      };
    };
  };
}
