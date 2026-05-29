local exec_on_start = {
	"uwsm app -- avizo-service",
	"uwsm app -- hyprpm reload -n",
	"uwsm app -- hyprsunset",
	"uwsm app -- hyprland-per-window-layout",
	"uwsm app -- udiskie",
	"uwsm app -- kitty",
	"uwsm app -- brave",
	"uwsm app -- tauon",
	"uwsm app -- /usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1",
	"uwsm app -- wl-paste --watch cliphist store",
	"uwsm app -- dbus-update-activation-environment --systemd --all",
	"uwsm app -- pipewire",
	"uwsm app -- /usr/lib/xdg-desktop-portal-hyprland",
	"uwsm app -- /usr/lib/xdg-desktop-portal-gtk",
	"uwsm app -- /usr/lib/xdg-desktop-portal",
	"uwsm app -- blueman-applet",
	"uwsm app -- nm-applet --indicator",
	"uwsm app -- awww-daemon --format xrgb",
	"uwsm app -- waypaper --restore --backend awww",
	"uwsm app -- swaync",
	"bruno",
	"/opt/Beekeeper Studio/beekeeper-studio",
}

hl.on("hyprland.start", function()
	for _, cmd in ipairs(exec_on_start) do
		hl.exec_cmd(cmd)
	end
end)
