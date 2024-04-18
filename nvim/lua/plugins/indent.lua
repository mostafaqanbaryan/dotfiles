return {
	"shellRaining/hlchunk.nvim",
	event = { "UIEnter" },
	lazy = false,
	config = function()
		local palette = require('rose-pine.palette')
		require("hlchunk").setup({
			line_num = {
				enable = true,
				use_treesitter = false,
				style = "#806d9c",
			},
			blank = {
				enable = false,
			},
			indent = {
				enable = true,
				chars = {
					"┊",
				},
				exclude_filetypes = {
					startify = true
				},
			},
			chunk = {
				enable = true,
				error_sign = true,
				notify = true,
				use_treesitter = true,
				exclude_filetypes = {
					startify = true
				},
				chars = {
					horizontal_line = "─",
					vertical_line = "│",
					left_top = "╭",
					left_bottom = "╰",
					right_arrow = "─",
				},
				style = {
					{ fg = palette.pine },
					{ fg = palette.love }
				}
			}
		})
	end
}
