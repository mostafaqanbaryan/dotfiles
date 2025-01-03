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
vim.opt.expandtab = true
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
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.signcolumn = 'yes'

vim.o.foldcolumn = '1' -- '0' is not bad
vim.o.foldlevel = 0
vim.o.foldlevelstart = 99
vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldenable = true
vim.opt.foldmethod = 'manual'
-- vim.opt.foldmethod = 'expr'
-- vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

-- Case insensitive UNLESS using uppercase characters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Add indent for p/li in html
vim.g.html_indent_tags = 'li│p'

local function paste()
    return {
        vim.fn.split(vim.fn.getreg(""), "\n"),
        vim.fn.getregtype(""),
    }
end
vim.g.clipboard = {
    name = 'OSC 52',
    copy = {
        ['+'] = require('vim.ui.clipboard.osc52').copy('+'),
        ['*'] = require('vim.ui.clipboard.osc52').copy('*'),
    },
    paste = {
        ['+'] = paste,
        ['*'] = paste,
    },
}
