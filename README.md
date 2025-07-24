<h1 align="center">HPCesia's Nix Config</h1>

English | [简体中文](./README.zh-CN.md)

My Nix configuration for a NixOS laptop and a NixOS VPS.

## Component List

|                             | NixOS                                                        |
| --------------------------- | ------------------------------------------------------------ |
| **Desktop**                 | [KDE Plasma 6][kde-plasma]                                   |
| **Terminal Emulator**       | [WezTerm][wezterm] + [Ghostty][ghostty]                      |
| **Terminal Multiplexer**    | [Zellij][zellij]                                             |
| **Shell**                   | [Fish][fish] + [Starship][starship]                          |
| **Input Method**            | [Fcitx5][fcitx5] + [Rime][rime]                              |
| **Color Theme**             | [Catppuccin Macchiato][catppuccin]                           |
| **File Manager**            | [Yazi][yazi] + [Dolphin][kde-dolphin]                        |
| **Development Environment** | [VSCode][vscode] + [Helix][helix] (with [Zide][zide])        |
| **Browser**                 | [Firefox][firefox] + [Chromium][chromium] (backup)           |
| **Secret Management**       | [sops-nix][sops-nix], see [`./secrets`](./secrets/README.md) |

## Deployment

> [!WARNING]
> You should not deploy this configuration directly on your host, as it contains secrets that only I can decrypt and use.
>
> This configuration includes some hardcoded absolute paths and should be placed in the home directory at `~/nix-config`.

### For Local NixOS

```bash
sudo nixos-rebuild switch --flake .#kevin
```

### For Remote NixOS

```bash
colmena apply
```

## Acknowledgments

- Nix Flakes
  - [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config): The foundational architecture of this configuration originates from here.
  - [kamadorueda/machine](https://github.com/kamadorueda/machine): Resolves the issue with writing to VSCode's `settings.json`.
- Dotfiles
  - [yyhhyyyyyy/selfproxy](https://github.com/yyhhyyyyyy/selfproxy): Referenced configurations for [mihomo][mihomo].

<!-- Link List -->

[catppuccin]: https://github.com/catppuccin/catppuccin
[chromium]: https://chromium.googlesource.com/chromium/src
[fcitx5]: https://github.com/fcitx/fcitx5
[firefox]: https://github.com/mozilla-firefox/firefox
[fish]: https://github.com/fish-shell/fish-shell
[ghostty]: https://github.com/ghostty-org/ghostty
[nushell]: https://github.com/nushell/nushell
[helix]: https://github.com/helix-editor/helix
[kde-dolphin]: https://invent.kde.org/system/dolphin
[kde-plasma]: https://invent.kde.org/plasma/plasma-desktop
[mihomo]: https://github.com/MetaCubeX/mihomo
[rime]: https://github.com/rime/librime
[starship]: https://github.com/starship/starship
[sops-nix]: https://github.com/Mic92/sops-nix
[wezterm]: https://github.com/wezterm/wezterm
[vscode]: https://github.com/microsoft/vscode
[yazi]: https://github.com/sxyazi/yazi
[zellij]: https://github.com/iXialumy/zellij
[zide]: https://github.com/josephschmitt/zide
