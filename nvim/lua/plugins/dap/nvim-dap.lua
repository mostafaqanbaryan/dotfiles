local initialize = function()
	vim.keymap.set("n", "<Up>", "<cmd>lua require('dap').step_up()<CR>")
	vim.keymap.set("n", "<Down>", "<cmd>DapStepOver<CR>")
	vim.keymap.set("n", "<Right>", "<cmd>DapStepInto<CR>")
	vim.keymap.set("n", "<Left>", "<cmd>DapStepOut<CR>")
	vim.keymap.set("n", "<F1>", function()
		require("dap.ui.widgets").hover()
	end)
	require("dap-view").open()
end

local terminate = function()
	require("dap").terminate()
	require("dap-view").close()
	vim.keymap.del("n", "<Up>")
	vim.keymap.del("n", "<Down>")
	vim.keymap.del("n", "<Right>")
	vim.keymap.del("n", "<Left>")
	vim.keymap.del("n", "<F1>")
end

return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"igorlfs/nvim-dap-view",
			opts = {
				windows = {
					terminal = {
						-- NOTE Don't copy paste this snippet
						-- Use the actual names for the adapters you want to hide
						-- `go` is known to not use the terminal.
						hide = { "go" },
					},
				},
			},
		},
	},
	keys = {
		{ "<F4>", "<cmd>DapViewToggle<CR>" },
		{ "<F5>", "<cmd>DapContinue<CR>" },
		{
			"<Leader><F5>",
			function()
				require("dap").run_last()
			end,
		},
		{
			"<F17>",
			function()
				require("dap").run_to_cursor()
			end,
		},
		{
			"<F6>",
			function()
				terminate()
			end,
		},

		{
			"<F12>",
			function()
				require("dap").toggle_breakpoint()
			end,
		},
		{
			"<Leader><F12>",
			function()
				vim.ui.input({ prompt = "Condition: " }, function(input)
					if input == "" then
						require("dap").toggle_breakpoint()
					else
						require("dap").set_breakpoint(input)
					end
				end)
			end,
		},
		{
			"<F24>",
			function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end,
		},
	},
	config = function()
		-- Load autocompletion for REPL
		vim.api.nvim_create_autocmd({ "FileType" }, {
			pattern = "dap-repl",
			callback = function()
				require("dap.ext.autocompl").attach()
			end,
		})

		vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "🔵", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointRejected", { text = "⭕", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapLogPoint", { text = "🟡", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })

		local dap = require("dap")

		dap.listeners.before.attach["dap-view-config"] = function()
			initialize()
		end

		dap.listeners.before.launch["dap-view-config"] = function()
			initialize()
		end

		dap.adapters.php = {
			type = "executable",
			command = "node",
			args = { vim.fn.stdpath("data") .. "/mason/packages/php-debug-adapter/extension/out/phpDebug.js" },
		}

		dap.configurations.php = {
			{
				type = "php",
				request = "launch",
				name = "Listen for Xdebug",
				port = 9003,
				pathMappings = {
					["/var/www/html"] = vim.fn.getcwd() .. "/html",
				},
			},
		}
	end,
}
