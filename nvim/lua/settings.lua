-- RTL
vim.opt.termbidi = true
vim.opt.mouse = a
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.encoding = 'utf-8'
vim.opt.shiftwidth = 4
vim.opt.showmatch = true
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.laststatus = 3
vim.opt.expandtab = true
vim.opt.preserveindent = true
vim.opt.scrolloff = 7
vim.opt.ruler = true
-- vim.opt.wh = 10
-- vim.opt.wmh = 10
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Show indentation
vim.opt.list = true
vim.o.listchars = 'multispace:┊   '

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
vim.opt.foldlevel = 2
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.signcolumn = 'yes'

-- Case insensitive UNLESS using uppercase characters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Add indent for p/li in html
vim.g.html_indent_tags = 'li│p'
