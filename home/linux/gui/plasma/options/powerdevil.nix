{...}: {
  # AC is compatible for all hosts
  programs.plasma.powerdevil.AC = {
    powerProfile = "performance";
    # Auto Power Save
    autoSuspend.action = "nothing";
    turnOffDisplay = {
      idleTimeout = 14400;
      idleTimeoutWhenLocked = 600;
    };
    dimDisplay.enable = false;
    # Actions
    whenLaptopLidClosed = "sleep";
    whenSleepingEnter = "standby";
    powerButtonAction = "hibernate";
  };
}
