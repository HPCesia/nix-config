{myvars, ...}: {
  programs.thunderbird = {
    enable = true;
    profiles.Default = {
      isDefault = true;
    };
  };

  accounts.email.accounts = {
    "${myvars.useremail}".thunderbird.enable = true;
    "hpcesia@outlook.com".thunderbird.enable = true;
  };
}
