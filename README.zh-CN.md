<h1 align="center">HPCesia's Nix Config</h1>

[English](./README.md) | 简体中文

我的 Nix 配置，用于一台 NixOS 笔记本和一台 NixOS VPS。

## 组件列表

|                | NixOS                                                               |
| -------------- | ------------------------------------------------------------------- |
| **桌面**       | [KDE Plasma 6][kde-plasma]                                          |
| **终端模拟器** | [WezTerm][wezterm] + [Ghostty][ghostty]                             |
| **终端复用器** | [Zellij][zellij]                                                    |
| **Shell**      | [Fish][fish] + [Starship][starship]                                 |
| **输入法**     | [Fcitx5][fcitx5] + [Rime][rime]                                     |
| **配色主题**   | [Catppuccin Macchiato][catppuccin]                                  |
| **文件管理**   | [Yazi][yazi] + [Dolphin][kde-dolphin]                               |
| **开发环境**   | [VSCode][vscode] + [Helix][helix] (with [Zide][zide])               |
| **浏览器**     | [Firefox][firefox] + [Chromium][chromium] (backup)                  |
| **机密管理**   | [sops-nix][sops-nix]，详见 [`./secrets`](./secrets/README.zh-CN.md) |

## 部署

> [!WARNING]
> 你不应该在你的主机上直接部署本配置，这个配置包含只有我自己可以解密使用的机密。
>
> 这个配置包含部分硬编码的绝对路径，应当放在主用户的 `~/nix-config` 中。

### 对于本地 NixOS

```bash
sudo nixos-rebuild switch --flake .#kevin
```

### 对于远程 NixOS

```bash
colmena apply
```

## 致谢

- Nix Flakes
  - [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config): 本配置的基础架构源自此配置。
  - [kamadorueda/machine](https://github.com/kamadorueda/machine): 解决 VSCode 的 `settings.json` 写入问题。
- Dotfiles
  - [yyhhyyyyyy/selfproxy](https://github.com/yyhhyyyyyy/selfproxy): 参考了 [mihomo][mihomo] 的相关配置。

<!-- 链接列表 -->

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
