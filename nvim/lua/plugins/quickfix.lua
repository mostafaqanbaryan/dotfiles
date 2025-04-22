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
				-- drop = O
				-- tabdrop =use tab drop to open the item, and close quickfix window
				-- tab = t
				-- tabb = T
				-- tabc = <C-t>
				-- split = <C-x>
				-- vsplit = <C-v>
				-- prevfile = <C-p>
				-- nextfile = <C-n>
				-- prevhist = <
				-- nexthist = >
				-- lastleave = '"
				-- stoggleup = <S-Tab>
				-- stoggledown = <Tab>
				-- stogglevm = <Tab>
				-- stogglebuf = '<Tab>
				-- sclear = z<Tab>
				-- pscrollorig = zo
				-- ptogglemode = zp
				-- ptoggleitem = p
				-- ptoggleauto = P
				-- filter = zn
				-- filterr = zN
				-- fzffilter = zf
			},
		})
	end,
}
