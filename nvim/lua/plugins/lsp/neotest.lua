return {
	"nvim-neotest/neotest",
	event = "VeryLazy",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"fredrikaverpil/neotest-golang",
		"olimorris/neotest-phpunit",
		"V13Axel/neotest-pest",
	},
	config = function()
		local n = require("neotest")
		n.setup({
			-- log_level = vim.log.levels.INFO,
			config = {
				status = {
					enabled = true,
					signs = true,
					virtual_text = true,
				},
			},

			adapters = {
				require("neotest-golang")({
					cwd = function()
						return vim.fs.root(0, { "go.work", "go.mod", ".git" })
					end,
				}),
				-- require("neotest-phpunit")({
				-- 	phpunit_cmd = function()
				-- 		return vim.tbl_flatten({
				-- 			"phpunit-test",
				-- 			vim.g.test_container,
				-- 		})
				-- 	end,
				-- }),
				require("neotest-pest")({
					results_path = function()
						return "/tmp/.pest-result.json"
					end,
					pest_cmd = function()
						return vim.tbl_flatten({
							"php-pest-test",
							vim.g.test_container,
						})
					end,
				}),
			},
		})

		-- Watch doesn't work in PHP, so handle it manually
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = "*Test.php",
			callback = function()
				if vim.g.test_container ~= nil then
					require("neotest").run.run(vim.fn.expand("%"))
				end
			end,
		})

		vim.api.nvim_create_user_command("NeotestContainer", function()
			local name = vim.fn.input("Enter test container name: ")
			vim.g.test_container = name
		end, {})

		vim.keymap.set("n", "<F8>", function()
			n.watch.toggle(vim.fn.expand("%"))
			n.summary.toggle()
		end)

		vim.keymap.set("n", "<F9>", function()
			n.run.run()
			n.summary.open()
		end)

		vim.keymap.set("n", "<F10>", function()
			n.run.run(vim.fn.expand("%"))
			n.summary.open()
		end)

		vim.keymap.set("n", "[t", function()
			n.jump.prev()
		end)

		vim.keymap.set("n", "]t", function()
			n.jump.next()
		end)

		vim.keymap.set("n", "[T", function()
			vim.api.close_all_floating_windows()
			n.jump.prev({ status = "failed" })
			n.output.open({ enter = false })
		end)

		vim.keymap.set("n", "]T", function()
			vim.api.close_all_floating_windows()
			n.jump.next({ status = "failed" })
			n.output.open({ enter = false })
		end)
	end,
}
