return {
	"kevinhwang91/nvim-bqf",
	branch = "main",
	event = "VeryLazy",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
	},
	config = function()
		require("bqf").setup({
			preview = {
				win_height = 9999,
			},
			func_map = {
				open = "o",
				openc = "<CR>",
				pscrollup = "<C-u>",
				pscrolldown = "<C-d>",
			},
		})
	end,
}
