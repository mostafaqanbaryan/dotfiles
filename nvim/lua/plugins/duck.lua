return {
	'tamton-aquib/duck.nvim',
	keys = {
		{ '<leader>dd', '<cmd>lua require("duck").hatch("🐤")<CR>', { mode = 'n' } },
		{ '<leader>dk', '<cmd>lua require("duck").cook("🐤")<CR>', { mode = 'n' } },
		{ '<leader>da', '<cmd>lua require("duck").cook_all("🐤")<CR>', { mode = 'n' } }
	},
}
