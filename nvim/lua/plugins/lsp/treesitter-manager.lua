return {
	"nvim-treesitter/nvim-treesitter",
	lazy = false,
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter").install({
			"html",
			"css",
			"javascript",
			"typescript",
			"tsx",
			"php",
			"lua",
			"go",
			"graphql",
			"vim",
			"fish",
		})
	end,
}
