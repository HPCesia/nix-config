{
  mylib,
  pkgs,
  ...
}: let
  baseExtensions = import ../baseExtensions.nix pkgs;
in {
  imports = mylib.scanModules ./.;

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
      "GitCommitPlugin.ShowEmoji" = false;
      "GitCommitPlugin.MaxSubjectCharacters" = 25;
      "github.copilot.advanced".useLanguageServer = true;
      "nix.enableLanguageServer" = true;
      "nix.serverSettings".nil.formatting.command = ["alejandra"];
      "evenBetterToml.formatter.alignEntries" = true;
      "evenBetterToml.formatter.alignComments" = true;
      "evenBetterToml.formatter.allowedBlankLines" = 1;
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
        # Normal
        "editor.fontSize"
        "editor.fontLigatures"
        "editor.guides.bracketPairs"
        "editor.formatOnSave"
        "terminal.integrated.fontSize"
        "workbench.colorTheme"
        "workbench.iconTheme"
        "workbench.startupEditor"
        # Extension
        "GitCommitPlugin.ShowEmoji"
        "GitCommitPlugin.MaxSubjectCharacters"
        "github.copilot.advanced"
        "nix.enableLanguageServer"
        "nix.serverSettings"
        "evenBetterToml.formatter.alignEntries"
        "evenBetterToml.formatter.alignComments"
        "evenBetterToml.formatter.allowedBlankLines"
      ];
    };

    extensions = baseExtensions;
  };
}
