return {
	"nvim-neotest/neotest",
	event = "VeryLazy",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"fredrikaverpil/neotest-golang",
		"olimorris/neotest-phpunit",
	},
	config = function()
		require("neotest").setup({
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
	end,
}
