local wezterm = require 'wezterm';
local dimmer = {brightness=0.1};

return {
    color_scheme = "Espresso",
    font = wezterm.font("Monego Ligatures"),
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
        {key="h", mods="SUPER", action=wezterm.action{ActivatePaneDirection="Left"}},
        {key="j", mods="SUPER", action=wezterm.action{ActivatePaneDirection="Down"}},
        {key="k", mods="SUPER", action=wezterm.action{ActivatePaneDirection="Up"}},
        {key="l", mods="SUPER", action=wezterm.action{ActivatePaneDirection="Right"}},
        {key="s", mods="SUPER", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
        {key="v", mods="SUPER", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
        {key="w", mods="SUPER", action=wezterm.action{CloseCurrentPane={confirm=true}}},
        {key="z", mods="SUPER", action="TogglePaneZoomState"},
        {key="r", mods="SUPER", action=wezterm.action.PaneSelect{alphabet="qweasdzxc"}},
        {key="F11", mods="", action="ToggleFullScreen"},
    },
}
