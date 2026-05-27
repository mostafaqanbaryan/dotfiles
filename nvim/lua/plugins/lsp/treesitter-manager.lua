return {
	"romus204/tree-sitter-manager.nvim",
	dependencies = {}, -- tree-sitter CLI must be installed system-wide
	event = "VeryLazy",
	config = function()
		require("tree-sitter-manager").setup({
			-- Default Options
			ensure_installed = {
				"html",
				"scss",
				"php",
				"go",
				"graphql",
				"typescript",
				"javascript",
				"tsx",
				"vim",
			},
			-- border = nil, -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
			-- auto_install = false, -- if enabled, install missing parsers when editing a new file
			-- highlight = true, -- treesitter highlighting is enabled by default
			-- languages = {}, -- override or add new parser sources
			-- parser_dir = vim.fn.stdpath("data") .. "/site/parser",
			-- query_dir = vim.fn.stdpath("data") .. "/site/queries",
			query_dir = vim.fn.stdpath("config") .. "/queries",
		})
	end,
}
