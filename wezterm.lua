local wezterm = require 'wezterm';
local act = wezterm.action

return {
    automatically_reload_config = true,
    color_scheme = "Catppuccin Macchiato",
    font = wezterm.font_with_fallback {
        "Monego Ligatures",
        "Vazir Code"
    },
    font_size = 12,
    line_height = 1.4,
    enable_tab_bar = false,
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

    keys = {
        {key="j", mods="META", action=act.SendKey{ key = 'DownArrow' }},
        {key="k", mods="META", action=act.SendKey{ key = 'UpArrow' }},
        {key="Enter", mods="META", action=act.Nop},
        {key="p", mods="CTRL | SHIFT", action=act.DisableDefaultAssignment},
        {key="F11", mods="", action="ToggleFullScreen"},
    },

    set_environment_variables = {
        VTE_VERSION = '6003',
    },

    quick_select_patterns = {
        '[^\\s]*[0-9]\\.[^\\s]*'
    }
}
