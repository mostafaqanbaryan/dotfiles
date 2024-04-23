return {
	'kevinhwang91/rnvimr',
	cmd = {
		'RnvimrToggle'
	},
	keys = {
		{ "<leader>e", "<cmd>RnvimrToggle<CR>" },
	},
	init = function()
		vim.g.rnvimr_enable_picker = true
		vim.g.rnvimr_enable_ex = true
		vim.g.rnvimr_draw_border = true
		vim.g.rnvimr_enable_bw = true
		vim.g.rnvimr_shadow_winblend = 40
		vim.g.rnvimr_border_attr = { fg = 14, bg = -1 }
		vim.cmd [[highlight link RnvimrNormal CursorLine]]
		vim.g.rnvimr_layout = {
			relative = 'editor',
			height   = math.floor(vim.api.nvim_win_get_height(0) * 0.9),
			width    = math.floor(vim.api.nvim_win_get_width(0) * 0.8),
			row      = math.floor(vim.api.nvim_win_get_height(0) * 0.1),
			col      = math.floor(vim.api.nvim_win_get_width(0) * 0.1),
			style    = 'minimal',
		}
	end
}
