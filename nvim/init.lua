vim.api.shell = '/bin/bash'
vim.loader.enable()

-- <Leader> as <space>
vim.g.mapleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Faster startup
require("lazy").setup({
    { import = "plugins.lsp" },
    { import = "plugins.git" },
    { import = "plugins" },
}, {
    defaults = {
        lazy = true
    },
    checker = {
        enabled = true,
        notify = false
    }
});

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
vim.o.timeout = 'timeoutlen: 1000, ttimeoutlen: 100'
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

vim.api.nvim_create_user_command('Config', ":exe 'edit ' . stdpath('config') . '/init.lua'", { bang = true, nargs = 0 })
vim.api.nvim_create_user_command('Reload', ":exe 'source ' . stdpath('config') . '/init.lua'", { bang = true, nargs = 0 })

-- Wordpress
vim.api.nvim_create_user_command('Sass', ":silent exe '!sass ' . expand('%:p') . ' ' . expand('%:p:r') . '.css'", {})

-- Clear and Redraw screen when an error happens
vim.keymap.set('n', '<Leader>l', ':redraw!<cr>')

-- ReRender syntax highlights
vim.keymap.set('n', '<F12>', ':syntax sync fromstart<CR>')
vim.keymap.set('i', '<F12>', '<ESC>:syntax sync fromstart<CR>a')

-- clear search
vim.keymap.set('n', '<leader>\\', ':let @/=""<CR>:nohlsearch<CR>', { silent = true })

-- Remap paste
vim.keymap.set('v', 'p', 'P')
vim.keymap.set('v', 'P', 'p')

-- Copy/Paste outside vim
vim.keymap.set('n', '<Leader>y', '"+yiw')
vim.keymap.set('v', '<Leader>y', '"+y')
vim.keymap.set('n', '<Leader>p', '"+p')
vim.keymap.set('v', '<Leader>p', '<Esc>o<Esc>"+p')

-- Copy full address
vim.keymap.set('n', '<Leader>x', ':let @+=expand("%")<CR>')

-- Toggle between 2 last files
vim.keymap.set('n', '<Leader><Leader>', '<C-^>')

-- Max height when opening files
-- vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead', 'BufEnter' }, { pattern = '*', command = 'resize' })

-- Working with split
-- vim.keymap.set('n', '<C-j>', '<C-W>j<C-W>_zz')
-- vim.keymap.set('n', '<C-k>', '<C-W>k<C-W>_zz')
-- vim.keymap.set('n', '<C-l>', '<C-W>l<C-W>_zz')
-- vim.keymap.set('n', '<C-h>', '<C-W>h<C-W>_zz')
vim.keymap.set('n', '<C-j>', '<C-W>j')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-l>', '<C-W>l')
vim.keymap.set('n', '<C-h>', '<C-W>h')
vim.keymap.set('n', '<C-<>', '<C-W>> " Increase split size')
vim.keymap.set('n', '<C->>', '<C-W>< " Decrease split size')

-- remap movement to move by column layout
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Aliases for different file types
vim.api.nvim_create_user_command('JSX', ':set ft = javascript.jsx', {})
vim.api.nvim_create_user_command('JS', ':set ft = javascript', {})
vim.api.nvim_create_user_command('HTML', ':set ft = html', {})
vim.api.nvim_create_user_command('PHP', ':set ft = php', {})
vim.api.nvim_create_user_command('SQL', ':set ft = sql', {})

-- Title as filename
vim.api.nvim_create_autocmd('BufEnter',
    { pattern = '*', command = 'let &titlestring = expand("%:t") . " (" . expand("%:~:h") . ") - Vim"' })
vim.opt.title = true

-- Search in VisualMode
vim.keymap.set('v', '/', 'y/<C-R>"<CR>')
vim.keymap.set('v', '/', 'y/<C-R>"<CR>')

-- Replace word under cursor
vim.keymap.set('n', 'cu', ':%s/<C-R><C-W>//cg<Left><Left><Left>')

-- Go to last buffer and delete the current one
vim.keymap.set('n', '<Leader>c', ':bnext<CR>:bd#<CR>', { silent = true })

-- Fold/Unfold saving
local auAutoSaveFolds = vim.api.nvim_create_augroup('AutoSaveFolds', { clear = true });
vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
    group = auAutoSaveFolds,
    pattern = '*.*',
    command = 'mkview 1',
})
vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    group = auAutoSaveFolds,
    pattern = '*.*',
    command = 'silent! loadview 1',
})

vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-f>', '<C-f>zz')
vim.keymap.set('n', '<C-b>', '<C-b>zz')

-- JSX Syntax to JS
vim.go.syntastic_javascript_checkers = 'eslint'
vim.go.syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'

-- Lazygit
vim.keymap.set('n', '<Leader>g', ':silent exec "!zellij action new-pane --name Lazygit -c -f -- lazygit"<CR>',
    { silent = true })

-- Prettier on save
-- vim.api.nvim_create_user_command('Prettier', ":call CocAction('runCommand', 'prettier.formatFile')", { bang = true, nargs = 0 })
-- vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
--     group = auQuickfix,
--     pattern = '*.php',
--     command = 'execute "Prettier"',
-- })

local auQuickfix = vim.api.nvim_create_augroup('quickfix', { clear = true });
vim.api.nvim_create_autocmd({ 'QuickFixCmdPost' }, {
    group = auQuickfix,
    pattern = '[^l]*',
    command = 'cwindow',
})
vim.api.nvim_create_autocmd({ 'QuickFixCmdPost' }, {
    group = auQuickfix,
    pattern = 'l*',
    command = 'lwindow',
})
