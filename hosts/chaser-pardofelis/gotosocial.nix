{config, ...}: {
  services.gotosocial = {
    enable = true;
    settings = {
      # Basic
      host = "trin.one";
      bind-address = "localhost";
      port = 9291;
      protocol = "https"; # Final used protocol, should be `https` even when utilizing a reverse proxy.
      # Storage
      db-type = "sqlite";
      db-address = "/var/lib/gotosocial/sqlite.db";
      storage-backend = "s3";
      storage-s3-bucket = "trin-one";
      storage-s3-redirect-url = "https://asset.trin.one";
      # Instance
      landing-page-user = "hpcesia";
      instance-languages = ["zh-Hans"];
      instance-expose-public-timeline = true;
      instance-inject-mastodon-version = true;
      # SMTP
      smtp-host = "glacier.mxrouting.net";
      smtp-port = 587;
      smtp-username = "no-reply@trin.one";
      smtp-from = "no-reply@trin.one";
      # OIDC
      oidc-enabled = true;
      oidc-idp-name = "Authelia";
      oidc-issuer = "https://auth.trin.one";
      oidc-client-id = "gts-trinnon";
      oidc-scopes = ["openid" "email" "profile" "groups"];
      oidc-allowed-groups = [];
      oidc-admin-groups = ["admin"];
    };
    environmentFile = config.sops.templates.gotosocial-env.path;
  };

  sops.templates.gotosocial-env = {
    content = ''
      GTS_STORAGE_S3_ENDPOINT=${config.sops.placeholder.gotosocial-s3-endpoint}
      GTS_STORAGE_S3_ACCESS_KEY=${config.sops.placeholder.gotosocial-s3-access-key}
      GTS_STORAGE_S3_SECRET_KEY=${config.sops.placeholder.gotosocial-s3-secret-key}
      GTS_OIDC_CLIENT_SECRET=${config.sops.placeholder.gotosocial-oidc-secret}
      GTS_SMTP_PASSWORD=${config.sops.placeholder.gotosocial-smtp-password}
    '';
    owner = "root";
    group = "gotosocial";
    mode = "0440";
  };
}
