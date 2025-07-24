{...}: {
  services.goatcounter = {
    enable = true;
    address = "127.0.0.1";
    port = 4627;
    proxy = true;
    extraArgs = [];
  };
}
