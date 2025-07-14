{lib, ...}:
with lib; let
  hostModule = types.submodule {
    options = {
      network = mkOption {
        type = networkModule;
        default = {};
        description = "Network configurations of the host.";
      };
      hostPublicKey = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
      sshPorts = mkOption {
        type = types.listOf types.port;
        default = [22];
      };
    };
  };

  networkModule = types.submodule {
    options = {
      enable = mkOption {
        type = types.nullOr (types.enum ["networkmanager" "networkd"]);
        default = null;
        description = "Which network manager to use.";
      };
      iface = mkOption {
        type = types.str;
      };
      useDHCP = mkOption {
        type = types.bool;
        default = false;
      };
      nameservers = mkOption {
        type = types.listOf types.str;
        default = [];
      };
      search = mkOption {
        type = types.listOf types.str;
        default = [];
      };
      ipv4 = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
      ipv6 = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
      prefixLength4 = mkOption {
        type = types.int;
        default = 24;
      };
      prefixLength6 = mkOption {
        type = types.int;
        default = 64;
      };
      defaultGateway = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
      defaultGateway6 = mkOption {
        type = types.nullOr types.str;
        default = null;
      };
    };
  };
in {
  options.modules.my-hosts = mkOption {
    type = types.attrsOf hostModule;
    description = "My nix hosts general configuration";
    default = {};
  };
}
