{nixos-logo, ...}: {
  # Power Control
  programs.plasma.powerdevil = {
    AC.inhibitLidActionWhenExternalMonitorConnected = true;
    battery = {
      powerProfile = "powerSaving";
      # Auto Power Save
      autoSuspend = {
        action = "sleep";
        idleTimeout = 600;
      };
      turnOffDisplay = {
        idleTimeout = 360;
        idleTimeoutWhenLocked = 120;
      };
      dimDisplay = {
        enable = true;
        idleTimeout = 120;
      };
      # Actions
      whenLaptopLidClosed = "hibernate";
      whenSleepingEnter = "standbyThenHibernate";
      powerButtonAction = "shutDown";
      inhibitLidActionWhenExternalMonitorConnected = true;
    };
    lowBattery = {
      powerProfile = "powerSaving";
      # Auto Power Save
      autoSuspend = {
        action = "sleep";
        idleTimeout = 300;
      };
      turnOffDisplay = {
        idleTimeout = 180;
        idleTimeoutWhenLocked = 60;
      };
      dimDisplay = {
        enable = true;
        idleTimeout = 60;
      };
      # Actions
      whenLaptopLidClosed = "hibernate";
      whenSleepingEnter = "standbyThenHibernate";
      powerButtonAction = "shutDown";
      inhibitLidActionWhenExternalMonitorConnected = true;
    };
  };

  programs.fastfetch.settings.logo = {
    type = "kitty-direct";
    source = "${nixos-logo}/nixos-griseo.png";
    height = 15;
    width = 32;
  };
}
