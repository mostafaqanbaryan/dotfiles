local getRoot = function()
	local root = vim.fs.root(0, { ".git" })
	if not root then
		root = "."
	end
	return root
end

return {
	"leoluz/nvim-dap-go",
	dependencies = {
		"mfussenegger/nvim-dap",
	},
	ft = "go",
	config = function()
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
			},
			dap_configurations = config,
		})

		vim.api.nvim_create_user_command("DapRunProject", function()
			require("dap").run(config[2])
		end, { desc = "Run " .. config[2].name })

		vim.api.nvim_create_user_command("DapRunWeb", function()
			require("dap").run(config[3])
		end, { desc = "Run " .. config[3].name })

		vim.api.nvim_create_user_command("DapRunCli", function()
			require("dap").run(config[4])
		end, { desc = "Run " .. config[4].name })
	end,
}
