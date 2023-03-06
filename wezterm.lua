local wezterm = require 'wezterm';
local dimmer = {brightness=0.1};
local act = wezterm.action

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
    -- Each element holds the text for a cell in a "powerline" style << fade
    local cells = {}
    local window_dims = window:get_dimensions()
    local is_big_window = window_dims.pixel_width > 700;
    local is_medium_window = window_dims.pixel_width > 500;

    -- Figure out the cwd and host of the current pane.
    -- This will pick up the hostname for the remote host if your
    -- shell is using OSC 7 on the remote host.
    local cwd_uri = pane:get_current_working_dir()
    local is_ssh = not (not pane:get_user_vars().SSH_ENV or pane:get_user_vars().SSH_ENV == '')
    if cwd_uri then
        cwd_uri = cwd_uri:sub(8)
        local slash = cwd_uri:find '/'
        local cwd = ''
        local hostname = ''
        if slash then
            hostname = cwd_uri:sub(1, slash - 1)
            -- Remove the domain name portion of the hostname
            local dot = hostname:find '[.]'
            if dot then
             hostname = hostname:sub(1, dot - 1)
            end

            -- SSH
            if is_ssh then
                hostname = '󱘖 ' .. pane:get_user_vars().SSH_ENV
            end

            -- and extract the cwd from the uri
            if is_medium_window then
                cwd = cwd_uri:sub(slash)
                table.insert(cells, cwd)
            end

            table.insert(cells, hostname)
        end
    end

    if is_big_window then
        -- I like my date/time in this style: "Wed Mar 3 08:14"
        local date = wezterm.strftime '%a %b %-d %H:%M:%S'
        table.insert(cells, date)
    end

    -- An entry for each battery (typically 0 or 1 battery)
    for _, b in ipairs(wezterm.battery_info()) do
        table.insert(cells, string.format('%.0f%%', b.state_of_charge * 100))
    end

    -- The powerline < symbol
    local LEFT_ARROW = utf8.char(0xe0b3)

    -- The filled in variant of the < symbol
    local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

    -- Color of host/ssh
    local hostname_bg = '#52307c'
    local hostname_fg = '#c0c0c0'
    if is_ssh then
        hostname_bg = '#ff6600'
        hostname_fg = '#ffffff'
    end

    -- Color palette for the backgrounds of each cell
    local bg_colors = {
        '#3c1361',
        hostname_bg,
        '#663a82',
        '#7c5295',
        '#b491c8',
    }

    -- Foreground color for the text across the fade
    local text_fg = '#c0c0c0'
    local fg_colors = {
        '#c0c0c0',
        hostname_fg,
        '#c0c0c0',
        '#c0c0c0',
        '#c0c0c0'
    }

    -- The elements to be formatted
    local elements = {}

    -- How many cells have been formatted
    local num_cells = 0

    -- Translate a cell into elements
    function push(text, is_last)
        local cell_no = num_cells + 1
        table.insert(elements, { Foreground = { Color = bg_colors[cell_no] } })
        table.insert(elements, { Text = SOLID_LEFT_ARROW })
        table.insert(elements, { Foreground = { Color = fg_colors[cell_no] } })
        table.insert(elements, { Background = { Color = bg_colors[cell_no] } })
        table.insert(elements, { Text = ' ' .. text .. ' ' })
        num_cells = num_cells + 1
    end

    while #cells > 0 do
        local cell = table.remove(cells, 1)
        push(cell, #cells == 0)
    end

    window:set_right_status(wezterm.format(elements))
end)

return {
    set_environment_variables = {
    VTE_VERSION = '6003',
  },
    automatically_reload_config = true,
    color_scheme = "TokyoNight (Gogh)",
    font = wezterm.font_with_fallback {
        "Monego Ligatures",
        "Vazir Code"
    },
    colors = {
        tab_bar = {
            background = '#1A1B26',
        },
    },
    font_size = 12,
    line_height = 1.3,
    -- hide_tab_bar_if_only_one_tab = true,
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
