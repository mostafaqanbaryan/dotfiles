local wezterm = require 'wezterm';
local act = wezterm.action

return {
    automatically_reload_config = true,
    enable_kitty_keyboard = true,
    window_background_opacity = 0.9,
    color_scheme = "Catppuccin Macchiato",
    font = wezterm.font_with_fallback {
        {
            family = "Cascadia Code",
            harfbuzz_features = { 'ss01', 'ss02', 'ss03', 'ss19', 'ss20' },
        },
        "Vazir Code",
    },
    font_size = 12,
    line_height = 1.6,
    enable_tab_bar = true,
    use_fancy_tab_bar = true,
    hide_tab_bar_if_only_one_tab = true,
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
        { key = "s",     mods = "CTRL",         action = act.EmitEvent 'trigger-sessions' },
        { key = ";",     mods = "CTRL",         action = act.SendKey { key = 'b', mods = 'CTRL' } },
        { key = "j",     mods = "META",         action = act.SendKey { key = 'DownArrow' } },
        { key = "k",     mods = "META",         action = act.SendKey { key = 'UpArrow' } },
        { key = "Enter", mods = "META",         action = act.Nop },
        { key = "p",     mods = "CTRL | SHIFT", action = act.DisableDefaultAssignment },
        { key = "F11",   mods = "",             action = "ToggleFullScreen" },
    },

    set_environment_variables = {
        VTE_VERSION = '6003',
    },

    quick_select_patterns = {
        '[^\\s]*[0-9]\\.[^\\s]*'
    }
}
