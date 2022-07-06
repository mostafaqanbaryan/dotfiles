local wezterm = require 'wezterm';
local dimmer = {brightness=0.1};

return {
    window_decorations = "NONE",
    color_scheme = "Espresso",
    font = wezterm.font("Monego Ligatures"),
    font_size = 10.7,
    line_height = 1.3,
    hide_tab_bar_if_only_one_tab = true,
    warn_about_missing_glyphs = false,
    bidi_enabled = true,
    window_padding = {
        left = 2,
        right = 2,
        top = 0,
        bottom = 0,
    },
    window_background_image = "~/terminal.jpg",
    window_background_image_hsb = {
        brightness = 0.43,
        hue = -0.5,
    },
    inactive_pane_hsb = {
        hue = 0.5,
        saturation = 0.9,
        brightness = 0.3,
    },

    keys = {
        {key="h", mods="META", action=wezterm.action{ActivatePaneDirection="Left"}},
        {key="j", mods="META", action=wezterm.action{ActivatePaneDirection="Down"}},
        {key="k", mods="META", action=wezterm.action{ActivatePaneDirection="Up"}},
        {key="l", mods="META", action=wezterm.action{ActivatePaneDirection="Right"}},
        {key="s", mods="META", action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
        {key="v", mods="META", action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
        {key="w", mods="META", action=wezterm.action{CloseCurrentPane={confirm=true}}},
        {key="z", mods="META", action="TogglePaneZoomState"},
        {key="r", mods="META", action=wezterm.action.PaneSelect{alphabet="qweasdzxc"}},
        {key="F11", mods="", action="ToggleFullScreen"},
    },
}
