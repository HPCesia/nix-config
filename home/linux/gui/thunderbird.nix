{myvars, ...}: {
  programs.thunderbird = {
    enable = true;
    profiles.Default = {
      isDefault = true;
      settings = {
        "extensions.autoDisableScopes" = 0;
      };
    };
  };

  catppuccin.thunderbird.profile = "Default";

  accounts.email.accounts = {
    "${myvars.useremail}".thunderbird.enable = true;
    "hpcesia@outlook.com".thunderbird.enable = true;
  };
}
