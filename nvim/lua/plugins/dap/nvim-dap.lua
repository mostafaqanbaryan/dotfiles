return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"theHamsta/nvim-dap-virtual-text",
		"nvim-neotest/nvim-nio",
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
		"DapWindow",
		"DapBreakpoint",
	},
	keys = {
		{ "<F5>", "<cmd>DapContinue<CR>" },
		{
			"<Leader><F5>",
			function()
				require("dap").run_last()
			end,
		},
		{ "<Leader>dc", "<cmd>DapRunToCursor<CR>" },
		{ "<F6>", "<cmd>DapTerminate<CR>" },

		{ "<F7>", "<cmd>DapStepOver<CR>" },
		{ "<F8>", "<cmd>DapStepInto<CR>" },
		{ "<F9>", "<cmd>DapStepOut<CR>" },

		{ "<F12>", "<cmd>DapBreakpoint<CR>" },
		{
			"<Leader>dl",
			function()
				require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
			end,
		},

		{ "<Leader>de", "<cmd>DapWindow<CR>" },

		{
			"<Leader>dh",
			function()
				require("dap.ui.widgets").hover()
			end,
			{ mode = { "n", "v" } },
		},
		{
			"<Leader>dp",
			function()
				require("dap.ui.widgets").preview()
			end,
			{ mode = { "n", "v" } },
		},

		{
			"<Leader>df",
			function()
				local widgets = require("dap.ui.widgets")
				widgets.centered_float(widgets.frames)
			end,
		},
		-- { '<Leader>ds', function()
		-- 	local widgets = require('dap.ui.widgets')
		-- 	widgets.centered_float(widgets.scopes)
		-- end },
	},
	config = function()
		vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapLogPoint", { text = "", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "", texthl = "", linehl = "", numhl = "" })

		require("nvim-dap-virtual-text").setup({
			enabled = true, -- enable this plugin (the default)
			enabled_commands = true, -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
			highlight_changed_variables = true, -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
			highlight_new_as_changed = false, -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
			show_stop_reason = true, -- show stop reason when stopped for exceptions
			commented = false, -- prefix virtual text with comment string
			only_first_definition = true, -- only show virtual text at first definition (if there are multiple)
			all_references = false, -- show virtual text on all all references of the variable (not only definitions)
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

		local dap, dv = require("dap"), require("dap-view")
		vim.api.nvim_create_user_command("DapBreakpoint", function()
			dap.toggle_breakpoint()
		end, { desc = "Set/unset breakpoint" })

		vim.api.nvim_create_user_command("DapRunToCursor", function()
			dap.run_to_cursor()
		end, { desc = "Run/Continue debugging to cursor position" })

		vim.api.nvim_create_user_command("DapWindow", function()
			dap.repl.toggle()
		end, { desc = "Open/close debug window" })

		dap.listeners.before.attach["dap-view-config"] = function()
			dv.open()
		end
		dap.listeners.before.launch["dap-view-config"] = function()
			dv.open()
		end
		dap.listeners.before.event_terminated["dap-view-config"] = function()
			dv.close()
		end
		dap.listeners.before.event_exited["dap-view-config"] = function()
			dv.close()
		end
	end,
}
