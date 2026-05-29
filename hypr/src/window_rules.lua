hl.window_rule({
	name = "workspace-1-browsers",
	match = {
		class = "^(Google-chrome|google-chrome|brave-browser|Brave-browser|Vivaldi|Vivaldi-stable)$",
	},
	workspace = 1,
})

hl.window_rule({
	name = "workspace-2-terminals",
	match = {
		class = "^(wezterm|org.wezfurlong.wezterm|kitty|alacritty)$",
	},
	workspace = 2,
})

hl.window_rule({
	name = "workspace-3-bruno",
	match = {
		class = "^bruno$",
	},
	workspace = 3,
})

hl.window_rule({
	name = "workspace-4-beekeeper",
	match = {
		class = "^beekeeper-studio$",
	},
	workspace = 4,
})

hl.window_rule({
	name = "workspace-5-filemanagers",
	match = {
		class = "^(org.gnome.Nautilus|thunar)$",
	},
	workspace = 5,
})

hl.window_rule({
	name = "workspace-10-music",
	match = {
		class = "^(org.musikcube|tauonmb)$",
	},
	workspace = 10,
})

hl.window_rule({
	name = "floating-utilities",
	match = {
		class = "^(pavucontrol|nm-connection-editor)$",
	},
	float = true,
})

hl.window_rule({
	name = "center-rofi",
	match = {
		class = "^Rofi$",
	},

	float = true,
	center = true,
	stay_focused = true,
})

hl.window_rule({
	name = "add-to-clipboard-style",
	match = {
		title = "rofi - Add to Clipboard",
	},
	move = { "monitor_w * 0.5 - 300", 10 },
})
