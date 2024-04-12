return {
	'brenoprata10/nvim-highlight-colors',
	lazy = false,
	config = function()
		require("nvim-highlight-colors").setup({
			enable_tailwind = true,
		})
	end
}
