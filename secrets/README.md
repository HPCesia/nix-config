# Secret Management

> [!NOTE]
> This folder is **not** a module for password management. I use self-hosted [VaultWarden][vaultwarden] for password management.

All my secrets are managed using [sops][sops] and stored under this folder. Secrets can be decrypted using either my PGP key or the host's SSH key (i.e., `/etc/ssh/ssh_host_ed25519_key`) and are stored in the `/run/secrets` directory on the machine.

## Adding a New Host

Get the host's host key, here using the local machine's `/etc/ssh/ssh_host_ed25519_key.pub` as an example. Run `ssh-to-age` to obtain the age key.

```sh
nix-shell -p ssh-to-age --run 'cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age'
```

Add the generated age key under the top-level `keys` field in `.sops.yaml`, and reference it under the `key_groups` field in the required items under `creation_rules`. Then use `sops` to update all related secret files.

## Creating Secrets

Open the secret file in the terminal using sops:

```sh
sops secrets/secrets.yaml
```

Then edit and add new secret fields:

```yaml
this: "is a secret"
and: { a: { nest: secret } }
```

Next, edit and add the field in `/secrets/base.nix`:

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

You can then access the secrets elsewhere using `config.sops.secrets.<name>` or `config.sops.placeholder.<name>`.

## Creating a New Secret Type

Add a new regex matching group in the `creation_rules` field of `.sops.yaml`.

[sops]: https://github.com/getsops/sops
[vaultwarden]: https://github.com/dani-garcia/vaultwarden