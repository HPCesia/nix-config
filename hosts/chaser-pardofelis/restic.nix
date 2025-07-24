{
  config,
  lib,
  ...
}: {
  services.restic.backups."${config.modules.currentHost}-backup" = {
    initialize = true;
    passwordFile = config.sops.secrets.restic-backup-password.path;
    rcloneConfigFile = config.sops.templates."rclone-restic-backup.conf".path;
    repository = "rclone:Backup:/Backups/${config.modules.currentHost}-backup/";
    paths =
      (lib.mapAttrsToList (n: v: "/var/lib/authelia-${n}") config.services.authelia.instances)
      ++ [
        config.services.artalk.workdir
        "/var/lib/fail2ban"
        config.services.freshrss.dataDir
        "/var/lib/goatcounter"
        "/var/lib/gotosocial"
        config.services.grafana.dataDir
        "/var/lib/${config.services.victoriametrics.stateDir}"
      ];
    exclude = [
      "tmp"
      ".git"
      "cache"
      ".cache"
      "*_cache"
    ];
    timerConfig = {
      OnCalendar = "04:00";
      RandomizedDelaySec = "1h";
    };
    pruneOpts = [
      "--keep-daily 3"
      "--keep-weekly 3"
      "--keep-monthly 3"
      "--keep-yearly 3"
    ];
  };

  sops.templates."rclone-restic-backup.conf".content = ''
    [Backup]
    type = onedrive
    drive_id = 52CE3DAB18B4C557
    drive_type = personal
    token = ${config.sops.placeholder.rclone-restic-backup-token}
  '';
}
