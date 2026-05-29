local mainMod = "SUPER"

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd("kitty"))
hl.bind(
	mainMod .. " + d",
	hl.dsp.exec_cmd(
		'rofi -x11 -show drun -run-command "uwsm app -- {cmd}" -theme ~/.config/rofi/launchers/type-2/style-10.rasi --command ""'
	)
)
hl.bind(mainMod .. " + Escape", hl.dsp.exec_cmd("~/.local/bin/powermenu"))
-- hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("hyprctl switchxkblayout sem-usb-keyboard next"))
hl.bind("Print", hl.dsp.exec_cmd('grim - | wl-copy && notify-send -t 1000 "Screenshot copied!" -i 2'))
hl.bind(
	"ALT + Print",
	hl.dsp.exec_cmd(
		'grim -g "$(hyprctl activewindow | grep size | sed "s/,/x/" | sed "s/size:/$(hyprctl activewindow | grep "at:" | sed "s/at: //")/")" - | swappy -f -'
	)
)

-- Clipboard history
hl.bind(
	mainMod .. " + c",
	hl.dsp.exec_cmd(
		"~/.local/bin/rofi-clipboard -x11 -sorting-method fzf -p 'Clipboard' -theme '~/dotfiles/rofi/style.rasi'"
	)
)

-- Add to clipboard
hl.bind(
	mainMod .. " + SHIFT + c",
	hl.dsp.exec_cmd(
		"rofi -x11 -i -dmenu -l 0 -p 'Add to Clipboard' -theme '~/dotfiles/rofi/add-to-clipboard-style.rasi' | wl-copy"
	)
)

-- Emoji
hl.bind(
	mainMod .. " + e",
	hl.dsp.exec_cmd(
		"rofi -x11 -modi emoji -show emoji -sorting-method fzf -theme '~/dotfiles/rofi/style.rasi' -p 'Emoji'"
	)
)

-- Password manager
hl.bind(mainMod .. " + p", function()
	local id = os.getenv("BW_ID")
	if id == nil then
		hl.notification.create({
			text = "BW_ID not set!",
			duration = 5000,
			color = "#ff1ea3",
		})
	else
		hl.dispatch(
			hl.dsp.exec_cmd(
				"~/dotfiles/bitwarden-rofi/bwmenu --folder-id="
					.. id
					.. " --no-clear --auto-lock '-1' -- -x11 -sort -i -dmenu -matching fuzzy -sorting-method fzf -theme ~/dotfiles/rofi/style.rasi"
			)
		)
	end
end)

-- Basic Password manager
hl.bind(mainMod .. " + SHIFT + p", function()
	local id = os.getenv("BW_BASIC_ID")
	if id == nil then
		hl.notification.create({
			text = "BW_BASIC_ID not set!",
			duration = 5000,
			color = "#ff1ea3",
		})
	else
		hl.dispatch(
			hl.dsp.exec_cmd(
				"~/dotfiles/bitwarden-rofi/bwmenu --folder-id="
					.. id
					.. " --no-clear --auto-lock '-1' -- -x11 -sort -i -dmenu -matching fuzzy -sorting-method fzf -theme ~/dotfiles/rofi/style.rasi"
			)
		)
	end
end)

-- SSH
hl.bind(
	mainMod .. " + t",
	hl.dsp.exec_cmd("~/.local/bin/rofi-ssh -x11 -sorting-method fzf -p 'Server' -theme '~/dotfiles/rofi/style.rasi'")
)

-- Toggle control Center
hl.bind(mainMod .. " + SHIFT + n", hl.dsp.exec_cmd("swaync-client -t -sw"))

-- hl.bind(mainMod .. " + w", hl.dsp.exec_cmd("~/.local/bin/hyprtab"))
hl.bind(mainMod .. " + w", hl.dsp.group.toggle())
hl.bind(mainMod .. " + f", hl.dsp.window.fullscreen({ action = "toggle", mode = "maximized" }))
hl.bind(mainMod .. " + SHIFT + f", hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen" }))
hl.bind(mainMod .. " + space", hl.dsp.window.float())
hl.bind(mainMod .. " + q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + q", hl.dsp.window.kill())
hl.bind(mainMod .. " + m", hl.dsp.exit())

hl.bind(mainMod .. " + h", function()
	hl.dispatch(hl.dsp.window.fullscreen_state({ internal = 0, client = 0, action = "set" }))
	hl.dispatch(hl.dsp.group.prev())
	hl.dispatch(hl.dsp.focus({ direction = "left" }))
end)
hl.bind(mainMod .. " + l", function()
	hl.dispatch(hl.dsp.window.fullscreen_state({ internal = 0, client = 0, action = "set" }))
	hl.dispatch(hl.dsp.group.next())
	hl.dispatch(hl.dsp.focus({ direction = "right" }))
end)

hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))

hl.bind(mainMod .. " + SHIFT + h", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + j", hl.dsp.window.move({ direction = "down" }))
hl.bind(mainMod .. " + SHIFT + k", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + l", hl.dsp.window.move({ direction = "right" }))

hl.bind(mainMod .. " + z", hl.dsp.window.float({ action = "toggle" }))

-- Workspace binds
for i = 1, 10 do
	local key = i % 10 -- 10 maps to key 0
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Special workspace
hl.bind(mainMod .. " + s", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + s", hl.dsp.window.move({ workspace = "special:magic" }))

-- Resize submap
hl.bind(mainMod .. " + R", hl.dsp.submap("resize"))
hl.define_submap("resize", function()
	hl.bind("right", hl.dsp.window.resize({ x = 10, y = 0, relative = true }), { repeating = true })
	hl.bind("left", hl.dsp.window.resize({ x = -10, y = 0, relative = true }), { repeating = true })
	hl.bind("up", hl.dsp.window.resize({ x = 0, y = 10, relative = true }), { repeating = true })
	hl.bind("down", hl.dsp.window.resize({ x = 0, y = -10, relative = true }), { repeating = true })
	hl.bind("escape", hl.dsp.submap("reset"))
end)

-- Screen brightness controls
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("lightctl up"), { locked = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("lightctl down"), { locked = true })

-- Touchpad controls
hl.bind("XF86TouchpadToggle", hl.dsp.exec_cmd("toggle-touchpad"), { locked = true })

-- Monitor mode switcher
hl.bind("XF86Display", hl.dsp.exec_cmd("toggle-monitors"), { locked = true })

-- Pulse Audio controls
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("volumectl -u up"), { locked = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("volumectl -u down"), { locked = true })
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("volumectl toggle-mute"), { locked = true })
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("volumectl -m toggle-mute"), { locked = true })

-- Media
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind(mainMod .. " + down", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind(mainMod .. " + right", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind(mainMod .. " + left", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
