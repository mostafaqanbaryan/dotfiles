return {
	"nvim-neotest/neotest",
	event = "VeryLazy",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"fredrikaverpil/neotest-golang",
		"olimorris/neotest-phpunit",
	},
	config = function()
		require("neotest").setup({
			config = {
				status = {
					enabled = true,
					signs = true,
					virtual_text = true,
				},
			},

			adapters = {
				require("neotest-golang")(),
				require("neotest-phpunit")({
					phpunit_cmd = function()
						return vim.tbl_flatten({
							"php-test",
							vim.g.test_container,
						})
					end,
				}),
			},
		})

		vim.api.nvim_create_user_command("NeotestContainer", function()
			local name = vim.fn.input("Enter test container name: ")
			vim.g.test_container = name
		end, {})

		vim.keymap.set("n", "<F8>", function()
			require("neotest").watch.toggle(vim.fn.expand("%"))
			require("neotest").summary.toggle()
		end)

		vim.keymap.set("n", "<F9>", function()
			require("neotest").run.run()
			require("neotest").summary.open()
		end)

		vim.keymap.set("n", "<F10>", function()
			require("neotest").run.run(vim.fn.expand("%"))
			require("neotest").summary.open()
		end)

		vim.keymap.set("n", "[t", function()
			require("neotest").jump.prev()
		end)

		vim.keymap.set("n", "]t", function()
			require("neotest").jump.next()
		end)

		vim.keymap.set("n", "[T", function()
			require("neotest").jump.prev({ status = "failed" })
		end)

		vim.keymap.set("n", "]T", function()
			require("neotest").jump.next({ status = "failed" })
		end)
	end,
}
