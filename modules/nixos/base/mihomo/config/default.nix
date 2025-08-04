{mylib, ...}: {
  imports = mylib.scanModules ./.;

  # See /options/nixos/mihomo.nix
  services.mihomo.config = {
    mixed-port = 7154;
    allow-lan = true;
    mode = "rule";
    log-level = "warning";
    ipv6 = false;
    find-process-mode = "strict";
    external-controller = "127.0.0.1:9090";
    unified-delay = true;
    tcp-concurrent = true;
    global-client-fingerprint = "chrome";
    profile = {
      store-selected = true;
      store-fake-ip = true;
    };
  };
}
