return {
	'FabijanZulj/blame.nvim',
	cmd = {
		'BlameToggle'
	},
	keys = {
		{ '<Leader>B', '<cmd>BlameToggle<CR>', { silent = true } },
	},
	config = function()
		require("blame").setup({
			date_format = "%Y.%m.%m",
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
