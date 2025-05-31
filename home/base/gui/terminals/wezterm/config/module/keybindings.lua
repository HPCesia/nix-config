local wezterm = require 'wezterm'
local module = {}

function module.apply(config)
    -- 禁用默认键绑定
    config.disable_default_key_bindings = true

    config.keys = {}
    local act = wezterm.action
    -- #===# 常规按键绑定 #===#
    -- 复制
    table.insert(config.keys,
        { key = 'c', mods = 'CTRL|SHIFT', action = act.CopyTo "Clipboard" }
    )
    table.insert(config.keys,
        { key = 'Copy', action = act.CopyTo "Clipboard" }
    )
    -- 粘贴
    table.insert(config.keys,
        { key = 'v', mods = 'CTRL|SHIFT', action = act.PasteFrom "Clipboard" }
    )
    table.insert(config.keys,
        { key = 'Paste', action = act.PasteFrom "Clipboard" }
    )
    -- Lua 配置 Debug 叠加层
    table.insert(config.keys,
        { key = 'l', mods = 'CTRL|SHIFT', action = act.ShowDebugOverlay }
    )
    -- 命令面板
    table.insert(config.keys,
        { key = 'p', mods = 'CTRL|SHIFT', action = act.ActivateCommandPalette }
    )
    -- 搜索
    table.insert(config.keys,
        { key = 'f', mods = 'CTRL|SHIFT', action = act.Search { CaseSensitiveString = "" } }
    )
end

return module
