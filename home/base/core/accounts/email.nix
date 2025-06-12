{
  pkgs,
  myvars,
  ...
}: let
  getPasswd = id: "${pkgs.rbw}/bin/rbw get ${id}";

  forwardEmailSettings = {
    imap = {
      host = "imap.forwardemail.net";
      port = 993;
      tls.enable = true;
    };
    smtp = {
      host = "smtp.forwardemail.net";
      port = 465;
    };
  };

  outlookSettings = {flavor = "outlook.office365.com";};
in {
  accounts.email.accounts = {
    "${myvars.useremail}" =
      forwardEmailSettings
      // {
        realName = myvars.userfullname;
        userName = myvars.useremail;
        address = myvars.useremail;
        primary = true;
        passwordCommand = getPasswd "6e58fb5d-1a74-4fd8-8b88-d793a43ea218";
      };
    "hpcesia@outlook.com" =
      outlookSettings
      // {
        realName = myvars.userfullname;
        userName = "hpcesia@outlook.com";
        address = "hpcesia@outlook.com";
      };
  };
}
