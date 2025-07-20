{config, ...}: {
  services.artalk = {
    enable = true;
    settings = {
      host = "127.0.0.1";
      port = 23366;
      app_key = {_secret = config.sops.secrets.artalk-app-key.path;};
      debug = false;
      locale = "zh-CN";
      timezone = "Asia/Shanghai";
      login_timeout = 259200;
      db = {
        type = "sqlite";
        file = "./data/artalk.db";
        user = "artalk";
        charset = "utf8mb4";
      };
      log = {
        enabled = true;
        filename = "./data/artalk.log";
      };
      trusted_domains = [
        "https://blog.hpcesia.com"
      ];
      moderator = {
        pending_default = true;
        api_fail_block = true;
        akismet_key = {_secret = config.sops.secrets.artalk-akismet-key.path;};
      };
      captcha = {
        enabled = true;
        captcha_type = "image";
      };
      img_upload.enable = false;
      email = {
        enabled = true;
        send_type = "smtp";
        send_name = "{{reply_nick}}";
        send_addr = "info@hpcesia.com";
        mail_subject = "[{{site_name}}] 您收到了来自 @{{reply_nick}} 的回复";
        mail_tpl = "default";
        smtp = {
          host = "glacier.mxrouting.net";
          port = 465;
          username = "info@hpcesia.com";
          password = {_secret = config.sops.secrets.artalk-email-password.path;};
        };
      };
      admin_notify = {
        notify_tpl = "default";
        notify_pending = true;
        email = {
          enabled = true;
          mail_subject = "[{{site_name}}] 您的文章「{{page_title}}」有新回复";
        };
      };
      auth = {
        enabled = true;
        anonymous = true;
        callback = "https://artalk.hpcesia.com/api/v2/auth/{provider}/callback";
        email = {
          enabled = true;
          verify_subject = "您的验证码是 - {{code}}";
          verify_tpl = "default";
        };
        github = {
          enabled = true;
          client_id = {_secret = config.sops.secrets.artalk-github-client-id.path;};
          client_secret = {_secret = config.sops.secrets.artalk-github-client-secret.path;};
        };
      };
      frontend = {
        placeholder = "来都来了，不如说点什么吧！";
        emoticons = "https://blog.hpcesia.com/assets/emotion.json";
        gravatar = {
          mirror = "https://weavatar.com/avatar/";
          params = "sha256=1&d=mp&s=240";
        };
        imgLazyLoad = "native";
        versionCheck = false;
      };
    };
  };
}
