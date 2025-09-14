return {
	"mfussenegger/nvim-dap",
	dependencies = {
		{
			"theHamsta/nvim-dap-virtual-text",
			config = function()
				require("nvim-dap-virtual-text").setup({
					enabled = true, -- enable this plugin (the default)
					enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
					highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
					highlight_new_as_changed = true, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
					show_stop_reason = true, -- show stop reason when stopped for exceptions
					commented = false, -- prefix virtual text with comment string
					only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
					all_references = false, -- show virtual text on all references of the variable (not only definitions)
					clear_on_continue = false, -- clear virtual text on "continue" (might cause flickering when stepping)
					display_callback = function(variable, buf, stackframe, node, options)
						if options.virt_text_pos == "inline" then
							return " = " .. variable.value
						else
							return variable.name .. " = " .. variable.value
						end
					end,
					-- position of virtual text, see `:h nvim_buf_set_extmark()`, default tries to inline the virtual text. Use 'eol' to set to end of line
					virt_text_pos = "inline",

					-- experimental features:
					all_frames = false, -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
					virt_lines = false, -- show virtual lines instead of virtual text (will flicker!)
					virt_text_win_col = nil, -- position the virtual text at a fixed window column (starting from the first text column) ,
					-- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
				})
			end,
		},
		-- "nvim-neotest/nvim-nio",
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
	cmd = {
		"DapRunToCursor",
		"DapBreakpoint",
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
		{ "<F17>", "<cmd>DapRunToCursor<CR>" },
		{
			"<F6>",
			function()
				require("dap").terminate()
				require("dap-view").close()
				vim.keymap.del("n", "<Up>")
				vim.keymap.del("n", "<Down>")
				vim.keymap.del("n", "<Right>")
				vim.keymap.del("n", "<Left>")
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

		local dap, dv = require("dap"), require("dap-view")

		vim.api.nvim_create_user_command("DapRunToCursor", function()
			dap.run_to_cursor()
		end, { desc = "Run/Continue debugging to cursor position" })

		dap.listeners.before.attach["dap-view-config"] = function()
			vim.keymap.set("n", "<Up>", "<cmd>lua require('dap').step_up()<CR>")
			vim.keymap.set("n", "<Down>", "<cmd>DapStepOver<CR>")
			vim.keymap.set("n", "<Right>", "<cmd>DapStepInto<CR>")
			vim.keymap.set("n", "<Left>", "<cmd>DapStepOut<CR>")
			dv.open()
		end

		dap.listeners.before.launch["dap-view-config"] = function()
			vim.keymap.set("n", "<Up>", "<cmd>lua require('dap').step_up()<CR>")
			vim.keymap.set("n", "<Down>", "<cmd>DapStepOver<CR>")
			vim.keymap.set("n", "<Right>", "<cmd>DapStepInto<CR>")
			vim.keymap.set("n", "<Left>", "<cmd>DapStepOut<CR>")
			dv.open()
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
