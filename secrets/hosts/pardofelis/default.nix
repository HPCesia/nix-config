{
  lib,
  config,
  ...
}: let
  secretFileConf = {
    format = "yaml";
    sopsFile = ./secrets.yaml;
  };
in
  lib.mkMerge (
    [
      {
        sops.secrets = builtins.listToAttrs (builtins.map (x: {
          name = "pardofelis-${x}";
          value =
            {
              key = x;
            }
            // secretFileConf;
        }) ["ipv4" "ipv6" "gateway" "gateway6"]);
      }
    ]
    ++ lib.map (nvp: {
      sops.secrets.${nvp.name} =
        lib.mkIf
        (config.modules.currentHost == "pardofelis")
        nvp.value;
    }) (
      let
        artalkConf = {
          owner = "root";
          group = "artalk";
          mode = "0440";
        };
        autheliaMainConf = {
          owner = "root";
          group = "authelia-main";
          mode = "0440";
        };
      in [
        {
          name = "freshrss-admin-password";
          value =
            {
              key = "services/freshrss/defaultUserPassword";
              owner = "root";
              group = "freshrss";
              mode = "0440";
            }
            // secretFileConf;
        }
        {
          name = "grafana-admin-password";
          value =
            {
              key = "services/grafana/adminPassword";
              owner = "root";
              group = "grafana";
              mode = "0440";
            }
            // secretFileConf;
        }
        {
          name = "gotosocial-s3-endpoint";
          value = {key = "services/gotosocial/s3Endpoint";} // secretFileConf;
        }
        {
          name = "gotosocial-s3-access-key";
          value = {key = "services/gotosocial/s3AccessKey";} // secretFileConf;
        }
        {
          name = "gotosocial-s3-secret-key";
          value = {key = "services/gotosocial/s3SecretKey";} // secretFileConf;
        }
        {
          name = "authelia-main-oidc-hmac-secret";
          value =
            {key = "services/authelia/main/oidcHmacSecret";}
            // autheliaMainConf
            // secretFileConf;
        }
        {
          name = "authelia-main-oidc-issuer-private-key";
          value =
            {key = "services/authelia/main/oidcIssuerPrivateKey";}
            // autheliaMainConf
            // secretFileConf;
        }
        {
          name = "authelia-main-session-secret";
          value =
            {key = "services/authelia/main/sessionSecret";}
            // autheliaMainConf
            // secretFileConf;
        }
        {
          name = "authelia-main-jwt-secret";
          value =
            {key = "services/authelia/main/jwtSecret";}
            // autheliaMainConf
            // secretFileConf;
        }
        {
          name = "authelia-main-storage-encryption-key";
          value =
            {key = "services/authelia/main/storageEncryptionKey";}
            // autheliaMainConf
            // secretFileConf;
        }
        {
          name = "restic-backup-password";
          value = {key = "services/restic/password";} // secretFileConf;
        }
        {
          name = "artalk-akismet-key";
          value =
            {key = "services/artalk/akismetKey";}
            // artalkConf
            // secretFileConf;
        }
        {
          name = "artalk-app-key";
          value =
            {key = "services/artalk/appKey";}
            // artalkConf
            // secretFileConf;
        }
        {
          name = "artalk-email-password";
          value =
            {key = "services/artalk/emailPassword";}
            // artalkConf
            // secretFileConf;
        }
        {
          name = "artalk-github-client-id";
          value =
            {key = "services/artalk/githubClientId";}
            // artalkConf
            // secretFileConf;
        }
        {
          name = "artalk-github-client-secret";
          value =
            {key = "services/artalk/githubClientSecret";}
            // artalkConf
            // secretFileConf;
        }
      ]
    )
  )
