local getRoot = function()
	local root = vim.fs.root(0, { "go.mod" })
	if not root then
		root = vim.loop.cwd()
	end
	return root
end

local function pick_delve_port(fzf, callback)
	local handle = io.popen("docker ps --format '{{.Names}} {{.Ports}}' | grep '2345/tcp'")

	if not handle then
		vim.notify("Failed to get docker containers", vim.log.levels.ERROR)
		return
	end

	local output = handle:read("*a")
	handle:close()

	local lines = {}
	for line in output:gmatch("[^\r\n]+") do
		table.insert(lines, line)
	end

	if #lines == 0 then
		vim.notify("No delve containers found", vim.log.levels.WARN)
		return
	end

	fzf.fzf_exec(lines, {
		prompt = "Delve Containers> ",

		actions = {
			["default"] = function(selected)
				local line = selected[1]

				-- Example:
				-- auth 0.0.0.0:2345->2345/tcp
				local port = line:match(":(%d+)%-%>2345")

				if not port then
					vim.notify("Could not parse port", vim.log.levels.ERROR)
					return
				end

				callback(tonumber(port))
			end,
		},
	})
end

return {
	"leoluz/nvim-dap-go",
	dependencies = {
		"mfussenegger/nvim-dap",
	},
	ft = "go",
	config = function()
		local fzf = require("fzf-lua")

		local config = {
			{
				type = "go",
				name = "Attach remote",
				mode = "remote",
				request = "attach",
			},
			{
				type = "go",
				name = "Debug Project (/main.go)",
				request = "launch",
				program = getRoot() .. "/main.go",
			},
			{
				type = "go",
				name = "Debug Project (cmd/web/main.go)",
				request = "launch",
				program = getRoot() .. "/cmd/web/main.go",
			},
			{
				type = "go",
				name = "Debug Project (cmd/cli/main.go)",
				request = "launch",
				program = getRoot() .. "/cmd/cli/main.go",
			},
		}
		require("dap-go").setup({
			delve = {
				path = "dlv",
				initialize_timeout_sec = 20,
				port = "${port}",
				args = {},
				build_flags = {},
				detached = vim.fn.has("win32") == 0,
				cwd = getRoot(),
			},
			dap_configurations = config,
		})

		require("dap").adapters.go_remote = function(callback, config)
			callback({
				type = "server",
				host = "0.0.0.0",
				port = config.port,
			})
		end

		table.insert(require("dap").configurations.go, {
			type = "go_remote",
			name = "Attach Docker",
			request = "attach",
			mode = "remote",
			port = function()
				local co = coroutine.running()

				pick_delve_port(fzf, function(port)
					coroutine.resume(co, port)
				end)

				return coroutine.yield()
			end,
			host = "0.0.0.0",
			remotePath = "/app",
			cwd = "/app",
			program = "/app",
			substitutePath = {
				{
					from = getRoot(),
					to = "/app",
				},
			},
		})

		vim.api.nvim_create_user_command("DapGoProject", function()
			require("dap").run(config[2])
		end, { desc = "Run " .. config[2].name })

		vim.api.nvim_create_user_command("DapGoWeb", function()
			require("dap").run(config[3])
		end, { desc = "Run " .. config[3].name })

		vim.api.nvim_create_user_command("DapGoCli", function()
			require("dap").run(config[4])
		end, { desc = "Run " .. config[4].name })
	end,
}
