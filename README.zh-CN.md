<h1 align="center">HPCesia's Nix Config</h1>

[English](./README.md) | 简体中文

我的 Nix 配置，用于一台 NixOS 笔记本。

## 组件列表

|                | NixOS                                              |
| -------------- | -------------------------------------------------- |
| **桌面**       | [KDE Plasma 6][kde-plasma]                         |
| **终端模拟器** | [Ghostty][ghostty] + [WezTerm][wezterm]            |
| **终端复用器** | [Zellij][zellij]                                   |
| **Shell**      | [Nushell][nushell] + [Starship][starship]          |
| **输入法**     | [Fcitx5][fcitx5] + [Rime][rime]                    |
| **配色主题**   | [Catppuccin][catppuccin]                           |
| **文件管理**   | [Yazi][yazi] + [Dolphin][kde-dolphin]              |
| **开发环境**   | [VSCode][vscode] + [Helix][helix]                  |
| **浏览器**     | [Firefox][firefox] + [Chromium][chromium] (backup) |

## 致谢

- Nix Flakes
  - [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config): 本配置的基础架构源自此配置。
  - [kamadorueda/machine](https://github.com/kamadorueda/machine): 解决 VSCode 的 `settings.json` 写入问题。

<!-- 链接列表 -->

[catppuccin]: https://github.com/catppuccin/catppuccin
[chromium]: https://chromium.googlesource.com/chromium/src
[fcitx5]: https://github.com/fcitx/fcitx5
[firefox]: https://github.com/mozilla-firefox/firefox
[ghostty]: https://github.com/ghostty-org/ghostty
[nushell]: https://github.com/nushell/nushell
[helix]: https://github.com/helix-editor/helix
[kde-dolphin]: https://invent.kde.org/system/dolphin
[kde-plasma]: https://invent.kde.org/plasma/plasma-desktop
[rime]: https://github.com/rime/librime
[starship]: https://github.com/starship/starship
[wezterm]: https://github.com/wezterm/wezterm
[vscode]: https://github.com/microsoft/vscode
[yazi]: https://github.com/sxyazi/yazi
[zellij]: https://github.com/iXialumy/zellij
