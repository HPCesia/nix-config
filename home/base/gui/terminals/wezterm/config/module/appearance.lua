local wezterm = require 'wezterm'
local module = {}

module.status_override = nil

--- 获取当前是否为暗黑模式
--- @return boolean
function is_dark_mode()
    if wezterm.gui then
        return wezterm.gui.get_appearance():find("Dark")
    end
    return true
end

-- 绘制右侧状态栏
function draw_right_status(window)
    -- 默认显示主机名
    local center_text = wezterm.hostname()
    -- Leader 键按下时进行提示
    if module.status_override ~= nil then
        center_text = module.status_override
    elseif window:leader_is_active() then
        center_text = 'Leader Key'
    end

    -- 实心左箭头符号
    local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

    -- 获取当前窗口的配置，并从中获取配色方案
    local color_scheme     = window:effective_config().resolved_palette
    local bg               = color_scheme.background
    local fg               = color_scheme.foreground

    -- 获取当前窗口顶栏配色
    local frame_scheme     = window:effective_config().window_frame
    local tbar_inact_bg    = frame_scheme.inactive_titlebar_bg
    local tbar_act_bg      = frame_scheme.active_titlebar_bg
    local tbar_bg          = ''
    if window:is_focused() then
        tbar_bg = tbar_act_bg
    else
        tbar_bg = tbar_inact_bg
    end

    local right_status = {
        { Background = { Color = 'none' } },
        { Foreground = { Color = bg } },
        { Text = SOLID_LEFT_ARROW },
        { Background = { Color = bg } },
        { Foreground = { Color = fg } },
        { Text = ' ' .. center_text },
    }

    -- 制作渐变配色，仅在 Windows 下使用，用于与右上按钮过渡
    if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
        local gradient_step = 10
        local gradient_bgs = wezterm.color.gradient({ colors = { bg, tbar_bg } }, gradient_step)
        for i = 1, #gradient_bgs do
            table.insert(right_status, { Background = { Color = gradient_bgs[i] }, })
            table.insert(right_status, { Foreground = { Color = 'none' }, })
            table.insert(right_status, { Text = ' ' })
        end
    else
        table.insert(right_status, { Background = { Color = bg }, })
        table.insert(right_status, { Foreground = { Color = 'none' }, })
        table.insert(right_status, { Text = '  ' })

    end

    window:set_right_status(wezterm.format(right_status))
end

--- 获取正确的标签页标题
function tab_title(tab_info)
    local title = tab_info.tab_title
    if title and #title > 0 then
        return title
    end
    return tab_info.active_pane.title
end

function module.apply(config)
    -- 设置字体
    config.font = wezterm.font { family = 'Maple Mono NF CN' }

    -- 启用滚动条
    config.enable_scroll_bar = true

    -- 配色方案
    if is_dark_mode() then
        config.color_scheme = 'Catppuccin Macchiato'
    else
        config.color_scheme = 'Catppuccin Latte'
    end

    -- 初始窗口大小
    config.initial_cols = 128
    config.initial_rows = 32

    -- 背景透明度
    config.window_background_opacity = 0.4
    config.win32_system_backdrop = 'Acrylic'
    config.macos_window_background_blur = 20
    config.kde_window_background_blur = true

    -- 调整窗口边距
    config.window_padding = {
        left = "5pt",
        right = "5pt",
        top = "5pt",
        bottom = "5pt",
    }


    if wezterm.target_triple == 'x86_64-pc-windows-msvc' then
        -- 改为嵌入式顶栏
        config.window_decorations = 'INTEGRATED_BUTTONS|RESIZE'
    end

    -- 定制顶栏
    wezterm.on('update-right-status', draw_right_status)

    config.window_frame = {
        font = wezterm.font { family = 'Noto Sans SC', weight = 'Bold' },
        font_size = 10.0,
    }
end

return module
