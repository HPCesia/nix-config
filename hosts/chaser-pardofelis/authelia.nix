{config, ...}: {
  services.authelia.instances = {
    main = {
      enable = true;
      settings = {
        theme = "auto";
        default_2fa_method = "totp";
        log.level = "info";
        server = {
          address = "tcp://127.0.0.1:9091";
          endpoints.authz.forward-auth = {
            implementation = "ForwardAuth";
            authn_strategies = [
              {
                name = "HeaderAuthorization";
                schemes = ["Basic" "Bearer"];
              }
              {
                name = "CookieSession";
              }
            ];
          };
        };
        identity_validation.reset_password.jwt_algorithm = "HS512";
        identity_providers.oidc.clients = [
          {
            # Refer: https://www.authelia.com/integration/openid-connect/clients/forgejo
            client_id = "forgejo";
            client_name = "Forgejo";
            client_secret = ''{{ secret "${config.sops.secrets."authelia-main-client-secrets-forgejo".path}" }}'';
            public = false;
            authorization_policy = "two_factor";
            require_pkce = true;
            pkce_challenge_method = "S256";
            redirect_uris = [
              "https://repo.hpcesia.com/user/oauth2/Authelia/callback"
            ];
            scopes = ["openid" "email" "profile" "groups"];
            response_types = ["code"];
            grant_types = ["authorization_code"];
            access_token_signed_response_alg = "none";
            userinfo_signed_response_alg = "none";
            token_endpoint_auth_method = "client_secret_basic";
          }
        ];
        authentication_backend.file = {
          path = "/var/lib/authelia-main/users_database.yaml";
          password.algorithm = "argon2";
        };
        storage.local.path = "/var/lib/authelia-main/db.sqlite3";
        notifier.filesystem.filename = "/var/lib/authelia-main/notification.txt";
        totp = {
          disable = false;
          issuer = "hpcesia.com";
        };
        session.cookies = [
          {
            name = "authelia_session";
            domain = "hpcesia.com";
            authelia_url = "https://authelia.hpcesia.com";
            expiration = "1 hour";
            inactivity = "5 minutes";
            remember_me = "2 week";
          }
        ];
        access_control = {
          default_policy = "deny";
          rules = [
            {
              domain = "*.hpcesia.com";
              policy = "bypass";
              resources = ["^/api$" "^/api/"];
            }
            {
              domain = "*.hpcesia.com";
              policy = "one_factor";
            }
          ];
        };
        regulation = {
          max_retries = 3;
          find_time = "2 minutes";
          ban_time = "5 minutes";
        };
      };
      secrets = {
        jwtSecretFile = config.sops.secrets."authelia-main-jwt-secret".path;
        oidcHmacSecretFile = config.sops.secrets."authelia-main-oidc-hmac-secret".path;
        oidcIssuerPrivateKeyFile = config.sops.secrets."authelia-main-oidc-issuer-private-key".path;
        sessionSecretFile = config.sops.secrets."authelia-main-session-secret".path;
        storageEncryptionKeyFile = config.sops.secrets."authelia-main-storage-encryption-key".path;
      };
    };
  };
}
