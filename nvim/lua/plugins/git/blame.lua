return {
	'FabijanZulj/blame.nvim',
	cmd = {
		'BlameToggle'
	},
	keys = {
		{ '<Leader>b', '<cmd>BlameToggle<CR>', { silent = true } },
	},
	config = function()
		require("blame").setup({
			date_format = "%Y.%m.%d %H:%M:%S",
			mappings = {
				commit_info = "i",
				show_commit = "I",
				stack_push = "<CR>",
				stack_pop = "<ESC>",
				close = { "q" },
			}
		})
	end
}
