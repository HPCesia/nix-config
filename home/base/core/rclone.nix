{
  osConfig,
  config,
  ...
}: {
  programs.rclone = {
    enable = true;
    remotes = {
      OneDrive = {
        config = {
          type = "onedrive";
          drive_id = "52CE3DAB18B4C557";
          drive_type = "personal";
        };
        secrets = {
          token = osConfig.sops.secrets.rclone-onedrive-token.path;
        };
        mounts."/" = {
          enable = true;
          mountPoint = "${config.home.homeDirectory}/Remote/OneDrive";
        };
      };
    };
  };
}
