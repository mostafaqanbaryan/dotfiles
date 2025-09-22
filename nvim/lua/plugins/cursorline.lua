-- Highlight/underline word under cursor
return {
	"yamatsum/nvim-cursorline",
	lazy = false,
	config = function()
		require("nvim-cursorline").setup({
			cursorline = {
				enable = false,
			},
			cursorword = {
				enable = true,
				min_length = 3,
				hl = { underline = true },
			},
		})
	end,
}
