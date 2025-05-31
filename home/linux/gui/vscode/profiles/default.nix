{
  mylib,
  pkgs,
  ...
}: let
  baseExtensions = import ../baseExtensions.nix pkgs;
in {
  imports = mylib.scanPaths ./.;

  programs.vscode.profiles.default = {
    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;

    userSettings = {
      # --- Editor Settings ---
      "editor.fontSize" = 16;
      "editor.fontLigatures" = true;
      "editor.guides.bracketPairs" = true;
      "editor.formatOnSave" = true;
      # --- Terminal Settings ---
      "terminal.integrated.fontSize" = 14;
      # --- Workbench Settings ---
      "workbench.iconTheme" = "material-icon-theme";
      "workbench.startupEditor" = "none";
      # --- Extension Settings ---
      "nix.formatterPath" = "alejandra";
      # --- Other Settings ---
      "telemetry.telemetryLevel" = "off";
      "security.workspace.trust.untrustedFiles" = "open";
      "window.newWindowProfile" = "default";
      "workbench.settings.applyToAllProfiles" = [
        "editor.fontSize"
        "editor.fontLigatures"
        "editor.guides.bracketPairs"
        "editor.semanticTokenColorCustomizations"
        "terminal.integrated.fontSize"
        "workbench.iconTheme"
        "workbench.startupEditor"
      ];
    };

    extensions = baseExtensions;
  };
}
