# 机密管理

> [!NOTE]
> 此文件夹**不是**关于密码管理的模块，我使用自托管的 [VaultWarden][vaultwarden] 进行密码管理。

我的所有机密都使用 [sops][sops] 进行管理，存储在这一文件夹下。机密可以通过我的 PGP 密钥或主机的 ssh 密钥（也就是 `/etc/ssh/ssh_host_ed25519_key`）进行解密，并存储在机器的 `/run/secrets` 目录下。

## 添加新主机

首先

```sh
nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'
```

## 创建机密

在终端中使用 sops 打开机密所在的文件：

```sh
sops secrets/base/secrets.yaml
```

并编辑添加新的机密字段：

```yaml
this: "is a secret"
and: { a: { nest: secret } }
```

随后在 `/secrets/base/default.nix` 中编辑添加该字段

```nix
let
  mapSecrets = keys:
    builtins.listToAttrs (builtins.map (k: {
        name = k;
        value = {
          format = "yaml";
          sopsFile = ./secrets.yaml;
        };
      })
      keys);
in {
  sops.secrets = mapSecrets [
    "this"
    "and/a/nest"
  ];
}
```

即可在其他地方通过 `config.sops.secrets.<name>` 或 `config.sops.placeholder.<name>` 来调用机密。

## 创建新机密类型

在 `.sops.yaml` 中的 `creation_rules` 字段添加一个新的正则匹配组即可。

[sops]: https://github.com/getsops/sops
[vaultwarden]: https://github.com/dani-garcia/vaultwarden
