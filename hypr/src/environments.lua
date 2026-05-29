hl.env("XCURSOR_SIZE", "24")
hl.env("SSH_AUTH_SOCK", "$XDG_RUNTIME_DIR/gcr/ssh")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "auto")

-- Load env from hypr/.env
local file = io.open("./.config/hypr/.env", "r")
if not file then
	hl.notification.create({
		text = "No local .env is defined",
		duration = 5000,
		color = "#ff1ea3",
	})
	return
end

hl.notification.create({
	text = "Local .env is loaded",
	duration = 5000,
	color = "#ff1ea3",
})

local content = file:read("*a")
file:close()

for line in content:gmatch("([^%s]+)") do
	local key, value = line:match("([^=]+)=(.+)")
	if key and value then
		hl.env(key, value)
	end
end
