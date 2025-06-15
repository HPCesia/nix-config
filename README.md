<h1 align="center">HPCesia's Nix Config</h1>

English | [简体中文](./README.zh-CN.md)

My Nix configuration for a NixOS laptop.

## Component List

|                             | NixOS                                              |
| --------------------------- | -------------------------------------------------- |
| **Desktop**                 | [KDE Plasma 6][kde-plasma]                         |
| **Terminal Emulator**       | [Ghostty][ghostty] + [WezTerm][wezterm]            |
| **Terminal Multiplexer**    | [Zellij][zellij]                                   |
| **Shell**                   | [Nushell][nushell] + [Starship][starship]          |
| **Input Method**            | [Fcitx5][fcitx5] + [Rime][rime]                    |
| **Color Theme**             | [Catppuccin][catppuccin]                           |
| **File Manager**            | [Yazi][yazi] + [Dolphin][kde-dolphin]              |
| **Development Environment** | [VSCode][vscode] + [Helix][helix]                  |
| **Browser**                 | [Firefox][firefox] + [Chromium][chromium] (backup) |

## Acknowledgments

- Nix Flakes
  - [ryan4yin/nix-config](https://github.com/ryan4yin/nix-config): The foundational architecture of this configuration originates from here.
  - [kamadorueda/machine](https://github.com/kamadorueda/machine): Resolves the issue with writing to VSCode's `settings.json`.

<!-- Link List -->

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
