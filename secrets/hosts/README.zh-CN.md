# Host secrets

此文件夹下存放主机特定的设置，一般而言是 VPS 的 IP 地址。

## IP 机密管理

通过 `/modules/base/hosts.nix` 定义主机的部分通用设置选项，并在 `/hosts/general.nix` 中集中声明。在 `/modules/base/users.nix` 中将 IP 相关机密存入文件并引入 `knownHosts` 中；在 `/modules/nixos/base/networking.nix` 中将 IP 相关机密存入 systemd 的 drop-in 中。