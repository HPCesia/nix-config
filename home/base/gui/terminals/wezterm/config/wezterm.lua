local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

local appears = require 'module.appearance'
appears.apply(config)

local keybindings = require 'module.keybindings'
keybindings.apply(config)

-- 关闭窗口时无提示
config.window_close_confirmation = 'NeverPrompt'

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
    config.default_prog = { 'pwsh' }
else
    config.default_prog = { 'bash' }
end

return config