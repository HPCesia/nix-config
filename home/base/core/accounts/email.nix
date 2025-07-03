{
  pkgs,
  myvars,
  ...
}: let
  # forwardEmailSettings = {
  #   imap = {
  #     host = "imap.forwardemail.net";
  #     port = 993;
  #     tls.enable = true;
  #   };
  #   smtp = {
  #     host = "smtp.forwardemail.net";
  #     port = 465;
  #   };
  # };
  mxrouteEmailSettings = {
    imap = {
      host = "glacier.mxrouting.net";
      port = 993;
      tls.enable = true;
    };
    smtp = {
      host = "glacier.mxrouting.net";
      port = 465;
    };
  };

  outlookSettings = {flavor = "outlook.office365.com";};
in {
  accounts.email.accounts = {
    "${myvars.useremail}" =
      mxrouteEmailSettings
      // {
        realName = myvars.userfullname;
        userName = myvars.useremail;
        address = myvars.useremail;
        primary = true;
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
