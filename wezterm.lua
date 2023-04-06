local wezterm = require 'wezterm';
local act = wezterm.action
local topbarColor = '#1A1B26'
local pallete = {
    '#F14627',
    '#7A7688',
    '#16182D',
    '#BD9699',
    '#7C525D',
}

local function isViProcess(pane) 
    -- get_foreground_process_name On Linux, macOS and Windows, 
    -- the process can be queried to determine this path. Other operating systems 
    -- (notably, FreeBSD and other unix systems) are not currently supported
    return pane:get_foreground_process_name():find('n?vim') ~= nil
end

local function conditionalActivatePane(window, pane, pane_direction, vim_direction)
    if isViProcess(pane) then
        window:perform_action(
            -- This should match the keybinds you set in Neovim.
            act.SendKey({ key = vim_direction, mods = 'CTRL' }),
            pane
        )
    else
        window:perform_action(act.ActivatePaneDirection(pane_direction), pane)
    end
end

wezterm.on('ActivatePaneDirection-right', function(window, pane)
    conditionalActivatePane(window, pane, 'Right', 'l')
end)
wezterm.on('ActivatePaneDirection-left', function(window, pane)
    conditionalActivatePane(window, pane, 'Left', 'h')
end)
wezterm.on('ActivatePaneDirection-up', function(window, pane)
    conditionalActivatePane(window, pane, 'Up', 'k')
end)
wezterm.on('ActivatePaneDirection-down', function(window, pane)
    conditionalActivatePane(window, pane, 'Down', 'j')
end)

wezterm.on('update-status', function(window, pane)
    local window_dims = window:get_dimensions()
    local is_big_window = window_dims.pixel_width > 700;
    local is_medium_window = window_dims.pixel_width > 500;

    update_right(window, pane, is_big_window, is_medium_window)
    update_left(window, pane, is_big_window, is_medium_window)
end)

function update_right(window, pane, is_medium_window, is_big_window)
    local cells = {}
    local elements = {}
    local num_cells = 0
    local is_ssh = not (not pane:get_user_vars().SSH_ENV or pane:get_user_vars().SSH_ENV == '')
    local seperator = utf8.char(0xe0b6)

    local bg_colors = {
        pallete[5],
    }

    local fg_colors = {
        pallete[3],
    }

    -- Color of host/ssh
    if is_ssh then
        bg_colors[2] = pallete[1]
        fg_colors[2] = '#ffffff'
    end

    -- Ssh Hostname
    if is_ssh then
        table.insert(cells, '󱘖 ' .. pane:get_user_vars().SSH_ENV)
    end

    -- Datetime
    if is_big_window then
        local date = wezterm.strftime '%y/%m/%d'
        table.insert(cells, date)
    end

    -- An entry for each battery (typically 0 or 1 battery)
    for _, b in ipairs(wezterm.battery_info()) do
        table.insert(cells, string.format('%.0f%%', b.state_of_charge * 100))
    end

    while #cells > 0 do
        local cell = table.remove(cells, 1)
        push_to_topbar(elements, cell, num_cells, bg_colors, fg_colors, seperator, #cells == 0, true)
        num_cells = num_cells + 1
    end
    window:set_right_status(wezterm.format(elements))
end

function update_left(window, pane, is_medium_window, is_big_window)
    local cells = {}
    local elements = {}
    local num_cells = 0
    local seperator = utf8.char(0xe0ba)
    local bg_colors = {
        pallete[4],
    }

    local fg_colors = {
        pallete[3],
    }

    -- Title
    table.insert(cells, pane:get_title())

    while #cells > 0 do
        local cell = table.remove(cells, 1)
        push_to_topbar(elements, cell, num_cells, bg_colors, fg_colors, seperator, #cells == 0, false)
        num_cells = num_cells + 1
    end

    window:set_left_status(wezterm.format(elements))
end

function push_to_topbar(elements, text, num_cells, bg_colors, fg_colors, seperator, is_last, add_to_left)
    local cell_no = num_cells + 1
    if add_to_left then
        table.insert(elements, { Foreground = { Color = bg_colors[cell_no] } })
        table.insert(elements, { Text = seperator })
    end
    table.insert(elements, { Foreground = { Color = fg_colors[cell_no] } })
    table.insert(elements, { Background = { Color = bg_colors[cell_no] } })
    table.insert(elements, { Text = ' ' .. text .. ' ' })
    if not add_to_left then
        table.insert(elements, { Background = { Color = topbarColor } })
        table.insert(elements, { Foreground = { Color = bg_colors[cell_no] } })
        table.insert(elements, { Text = utf8.char(0xe0b4) })
    end
end

return {
    automatically_reload_config = true,
    color_scheme = "TokyoNight (Gogh)",
    font = wezterm.font_with_fallback {
        "Monego Ligatures",
        "Vazir Code"
    },
    colors = {
        tab_bar = {
            background = topbarColor,
        },
    },
    font_size = 12,
    line_height = 1.4,
    use_fancy_tab_bar = false,
    show_tabs_in_tab_bar = false,
    show_new_tab_button_in_tab_bar = false,
    warn_about_missing_glyphs = false,
    bidi_enabled = true,
    window_padding = {
        left = 0,
        right = 0,
        top = 0,
        bottom = 0
    },
    inactive_pane_hsb = {
        hue = 0.5,
        saturation = 0.9,
        brightness = 0.3,
    },

    keys = {
        {key="h", mods="META", action=act.SendKey{ key = 'LeftArrow' }},
        {key="j", mods="META", action=act.SendKey{ key = 'DownArrow' }},
        {key="k", mods="META", action=act.SendKey{ key = 'UpArrow' }},
        {key="l", mods="META", action=act.SendKey{ key = 'RightArrow' }},

        {key='h', mods='CTRL', action=act.EmitEvent('ActivatePaneDirection-left')},
        {key='j', mods='CTRL', action=act.EmitEvent('ActivatePaneDirection-down')},
        {key='k', mods='CTRL', action=act.EmitEvent('ActivatePaneDirection-up')},
        {key='l', mods='CTRL', action=act.EmitEvent('ActivatePaneDirection-right')},

        {key="s", mods="SUPER", action=act{SplitHorizontal={domain="CurrentPaneDomain"}}},
        {key="v", mods="SUPER", action=act{
            SplitPane={
                direction="Down",
                size={ Percent= 25 }
            }
        }},

        {key="w", mods="SUPER", action=act{CloseCurrentPane={confirm=true}}},
        {key="z", mods="SUPER", action="TogglePaneZoomState"},
        {key="F11", mods="", action="ToggleFullScreen"},
    },
    
    set_environment_variables = {
        VTE_VERSION = '6003',
    },
}
