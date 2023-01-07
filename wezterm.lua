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

return {
    color_scheme = "Espresso",
    font = wezterm.font_with_fallback {
        "Monego Ligatures",
        "Vazir Code"
    },
    font_size = 10.7,
    line_height = 1.3,
    hide_tab_bar_if_only_one_tab = false,
    warn_about_missing_glyphs = false,
    bidi_enabled = true,
    window_padding = {
        left = 2,
        right = 2,
        top = 0,
        bottom = 0,
    },
    window_background_image = "/home/mostafaqanbaryan/terminal.jpg",
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
    
}
