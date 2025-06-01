{
  mylib,
  pkgs,
  ...
}: let
  baseExtensions = import ../baseExtensions.nix pkgs;
in {
  imports = mylib.scanPaths ./.;

  programs.vscode.profiles.default = {
    userSettings = {
      # --- Editor Settings --- #
      "editor.fontSize" = 16;
      "editor.fontLigatures" = true;
      "editor.guides.bracketPairs" = true;
      "editor.formatOnSave" = true;
      "editor.unicodeHighlight.allowedLocales"."zh-hans" = true;
      # --- Terminal Settings --- #
      "terminal.integrated.fontSize" = 14;
      "terminal.integrated.minimumContrastRatio" = 1;
      # --- Workbench Settings --- #
      "workbench.colorTheme" = "Catppuccin Macchiato";
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.startupEditor" = "none";
      # --- Extension Settings --- #
      "nix.formatterPath" = "alejandra";
      # --- Update Settings --- #
      "extensions.autoCheckUpdates" = false;
      "extensions.autoUpdate" = false;
      "update.mode" = "none";
      # --- Other Settings --- #
      # Settings apply to all profiles
      "telemetry.telemetryLevel" = "off";
      "security.workspace.trust.untrustedFiles" = "open";
      "window.newWindowProfile" = "Default";
      "workbench.settings.applyToAllProfiles" = [
        "editor.fontSize"
        "editor.fontLigatures"
        "editor.guides.bracketPairs"
        "editor.formatOnSave"
        "terminal.integrated.fontSize"
        "workbench.colorTheme"
        "workbench.iconTheme"
        "workbench.startupEditor"
      ];
    };

    extensions = baseExtensions;
  };
}
