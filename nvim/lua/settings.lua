-- RTL
vim.opt.termbidi = true
vim.opt.mouse = "a"
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.encoding = 'utf-8'
vim.opt.showmatch = true
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.smartindent = true
vim.opt.autoindent = true

vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.laststatus = 3
vim.opt.expandtab = false
vim.opt.preserveindent = true
vim.opt.scrolloff = 7
vim.opt.ruler = true
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Highlight current line
vim.opt.cursorline = true
vim.opt.cursorlineopt = 'both'

-- Show search and replace result in split
vim.opt.inccommand = 'split'

-- Show indentation
vim.opt.list = true

-- Maintain undo history between sessions
vim.opt.undolevels = 500
vim.opt.undofile = true
vim.o.undodir = vim.fn.expand(vim.fn.stdpath("data") .. '/undodir')

vim.opt.updatetime = 400
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.o.timeoutlen = 1000
vim.o.ttimeoutlen = 100
vim.opt.linebreak = true
vim.opt.cindent = false
vim.opt.foldmethod = 'indent'
vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt.foldlevel = 0
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.signcolumn = 'yes'

-- Case insensitive UNLESS using uppercase characters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Add indent for p/li in html
vim.g.html_indent_tags = 'li│p'

vim.g.clipboard = {
	name = 'OSC 52',
	copy = {
		['+'] = require('vim.ui.clipboard.osc52').copy('+'),
		['*'] = require('vim.ui.clipboard.osc52').copy('*'),
	},
	paste = {
		['+'] = require('vim.ui.clipboard.osc52').paste('+'),
		['*'] = require('vim.ui.clipboard.osc52').paste('*'),
	},
}
