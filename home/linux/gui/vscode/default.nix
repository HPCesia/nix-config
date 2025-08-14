{
  config,
  lib,
  pkgs,
  ...
}: let
  inherit (lib.lists) concatLists;

  homeDir = config.home.homeDirectory;
  dataDir = config.xdg.dataHome;
  userDataDir = "${dataDir}/vscode/data";
  extensionsDir = "${dataDir}/vscode/extensions";

  pkg = pkgs.vscode.override {
    commandLineArgs = concatLists [
      ["--extensions-dir" extensionsDir]
      ["--user-data-dir" userDataDir]
      ["--locale" "zh-cn"]
      ["--ozone-platform-hint=auto"]
      ["--enable-wayland-ime"]
      ["--wayland-text-input-version=3"]
    ];
  };
in {
  imports = [./profiles];

  programs.vscode = {
    enable = true;
    package = pkg;
    mutableExtensionsDir = false;
  };

  # To solve VSCode wants to write settings.json
  # VSCode will reset per reboot/rebuild.
  systemd.user.services.vscode-setup = {
    Unit = {
      Description = "VSCode Setup service";
      After = ["graphical-session-pre.target"];
      Wants = ["graphical-session-pre.target"];
    };
    Install.WantedBy = ["graphical-session.target"];
    Service = {
      Type = "oneshot";
      ExecStart = lib.getExe (pkgs.writeShellApplication {
        name = "vscode-setup";
        text = ''
          if [ -d "${userDataDir}/User/globalStorage" ]; then
            mv "${userDataDir}/User/globalStorage" /tmp/vscode-globalStorage-$$
          fi
          if [ -d "${userDataDir}/User/workspaceStorage" ]; then
            mv "${userDataDir}/User/workspaceStorage" /tmp/vscode-workspaceStorage-$$
          fi

          rm -rf "${userDataDir}/User"
          rm -rf "${extensionsDir}"

          mkdir -p "${userDataDir}"
          mkdir -p "${extensionsDir}"

          cp -r --dereference --no-preserve=mode,ownership \
            "${homeDir}/.config/Code/User" "${userDataDir}/User"
          cp -r --dereference --no-preserve=mode,ownership \
            "${homeDir}/.vscode/extensions/." "${extensionsDir}"

          if [ -d /tmp/vscode-globalStorage-$$ ]; then
            mv /tmp/vscode-globalStorage-$$ "${userDataDir}/User/globalStorage"
          fi
          if [ -d /tmp/vscode-workspaceStorage-$$ ]; then
            mv /tmp/vscode-workspaceStorage-$$ "${userDataDir}/User/workspaceStorage"
          fi
        '';
      });
    };
  };
}
