vim.api.shell = '/bin/bash'

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
    { 'lewis6991/impatient.nvim', branch = 'main' },

    -- Theme
    { 'folke/tokyonight.nvim', branch = 'main' },

    -- Better notifications
    { 'folke/noice.nvim', branch = 'main' },
    { 'MunifTanjim/nui.nvim', branch = 'main' },
    { 'rcarriga/nvim-notify', branch = 'master' },

    -- Highlight word under cursor
    { 'yamatsum/nvim-cursorline', branch = 'main' },

    -- Fuzzy
    { 'junegunn/fzf', branch = 'master' },
    { 'junegunn/fzf.vim', branch = 'master' },

    -- EditorConfig
    { 'editorconfig/editorconfig-vim', branch = 'master' },

    -- Markdown
    { 'iamcco/markdown-preview.nvim', branch = 'master', build = 'cd app && yarn install', ft = 'markdown', lazy = true },

    -- Ranger
    { 'kevinhwang91/rnvimr', branch = 'main', keys = '<leader>e', lazy = true },

    -- Autopairs
    { 'windwp/nvim-autopairs', branch = 'master' },
    { 'alvan/vim-closetag', branch = 'master', ft = 'html', lazy = true },
    { 'tpope/vim-surround', branch = 'master' },

    -- LSP
    { 'neoclide/coc.nvim', branch = 'master', build = ':CocUpdate', lazy = true },
    { 'pangloss/vim-javascript', branch = 'master', ft = 'javascript', lazy = true },
    { 'cakebaker/scss-syntax.vim', branch = 'master', ft = 'sass', lazy = true },
    { 'HiPhish/rainbow-delimiters.nvim', branch = 'master' },

    -- Fix class/function name at top
    { 'nvim-treesitter/nvim-treesitter', branch = 'master', build = ':TSUpdate' },
    { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'master' },
    { 'nvim-treesitter/nvim-treesitter-context', branch = 'master' },
    { 'kiyoon/treesitter-indent-object.nvim', branch = 'master' },

    -- Git
    { 'lewis6991/gitsigns.nvim', branch = 'main' },
    { 'tpope/vim-fugitive', branch = 'master', lazy = true },
    { 'sindrets/diffview.nvim', branch = 'main', cmd = 'DiffviewOpen', lazy = true },

    -- Statusbar
    { 'nvim-lualine/lualine.nvim', branch = 'master' },
    { 'kyazdani42/nvim-web-devicons', branch = 'master' },

    -- Comment
    { 'tomtom/tcomment_vim', branch = 'master', keys = 'gcc', lazy = true },

    { 'L3MON4D3/LuaSnip', branch = 'master', build = 'make install_jsregexp', lazy = true },
    { 'honza/vim-snippets', branch = 'master', lazy = true },
    { 'mostafaqanbaryan/vim-snippets', branch = 'master', lazy = true },

    { 'godlygeek/tabular', branch = 'master', cmd = 'Tabular', lazy = true },
    { 'terryma/vim-multiple-cursors', branch = 'master', lazy = true },
    { 'tpope/vim-unimpaired', branch = 'master', lazy = true },
    { 'norcalli/nvim-colorizer.lua', branch = 'master', lazy = true },

    -- Welcome
    { 'mhinz/vim-startify', branch = 'master' }
});

-- Cache plugins
require('impatient')

-- RTL
vim.opt.termbidi = true
vim.opt.mouse=a
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.encoding = 'utf-8'
vim.opt.shiftwidth=4
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
vim.opt.scrolloff=7
vim.opt.ruler = true
vim.opt.wh = 10
vim.opt.wmh = 10
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Show indentation
vim.opt.list = true
vim.o.listchars = 'multispace: ┊   '

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

-- filetype plugin indent on
vim.g.startify_session_dir = '~/.config/nvim/sessions'

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
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead', 'BufEnter' }, { pattern = '*', command = 'resize' })

-- Working with split
vim.keymap.set('n', '<C-j>', '<C-W>j<C-W>_zz')
vim.keymap.set('n', '<C-k>', '<C-W>k<C-W>_zz')
vim.keymap.set('n', '<C-l>', '<C-W>l<C-W>_zz')
vim.keymap.set('n', '<C-h>', '<C-W>h<C-W>_zz')
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
vim.api.nvim_create_autocmd('BufEnter', { pattern = '*', command = 'let &titlestring = expand("%:t") . " (" . expand("%:~:h") . ") - Vim"' })
vim.opt.title = true

-- Search in VisualMode
vim.keymap.set('v', '/', 'y/<C-R>"<CR>')
vim.keymap.set('v', '/', 'y/<C-R>"<CR>')

-- Replace word under cursor
vim.keymap.set('n', 'cu', ':%s/<C-R><C-W>//cg<Left><Left><Left>')

-- Go to last buffer and delete the current one
vim.keymap.set('n', '<Leader>c', ':bnext<CR>:bd#<CR>', { silent = true })

-- Ranger
-- Make Ranger replace Netrw and be the file explorer
vim.go.rnvimr_enable_ex = 1
-- Make Ranger to be hidden after picking a file
vim.go.rnvimr_enable_picker = 1
-- Hide the files included in gitignore
vim.go.rnvimr_hide_gitignore = 0
-- Make Neovim wipe the buffers corresponding to the files deleted by Ranger
vim.go.rnvimr_enable_bw = 1
-- Add a shadow window, value is equal to 100 will disable shadow
vim.go.rnvimr_shadow_winblend = 70
vim.keymap.set('n', '<Leader>e', ':RnvimrToggle<CR>', { silent = true })

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

-- Tabular
vim.keymap.set('n', '<Leader>=', ':Tab /=<CR> :%retab!<CR>')
vim.keymap.set('n', '<Leader>:', ':Tab /:<CR> :%retab!<CR>')
vim.keymap.set('n', '<Leader>,', ':Tab /,<CR> :%retab!<CR>')

-- JSX Syntax to JS
vim.go.syntastic_javascript_checkers = 'eslint'
vim.go.syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'

-- EditorConfig
vim.go.EditorConfig_exclude_patterns = 'fugitive://.*,scp://.*'

-- Git
vim.keymap.set('n', '<Leader>g', ':silent exec "!zellij action new-pane --name Lazygit -c -f -- lazygit"<CR>', { silent = true })
vim.keymap.set('n', '<Leader>B', ':Git blame<CR>', { silent = true })

-- Git Fugitive - Conflict
vim.keymap.set('n', 'g[', ':diffget //2<CR>')
vim.keymap.set('v', 'g[', ':diffget //2<CR>')
vim.keymap.set('n', 'g]', ':diffget //3<CR>')
vim.keymap.set('v', 'g]', ':diffget //3<CR>')

-- COC mapping
-- Use <c-space> to trigger completion.
vim.keymap.set('i', '<c-space>', 'coc#refresh()', { silent = true, expr = true })
-- Use K to show documentation in preview window.
vim.keymap.set('n', 'K', ':call show_documentation()<CR>', { silent = true })
-- Symbol renaming.
vim.keymap.set('n', '<F2>', '<Plug>(coc-rename)', { silent = true })
-- Formatting selected code.
-- xmap <F12> <Plug>(coc-format-selected)
-- nmap <F12> <Plug>(coc-format-selected)

-- Add `:OR` command for organize imports of the current buffer.
vim.api.nvim_create_user_command('OR', ":call CocAction('runCommand', 'editor.action.organizeImport')", { bang = true, nargs = 0 })

-- Add `:Format` command to format current buffer.
vim.api.nvim_create_user_command('Format', ":call CocAction('format')", { bang = true, nargs = 0 })

local auMygroup = vim.api.nvim_create_augroup('mygroup', { clear = true });
vim.api.nvim_create_autocmd({ 'FileType' }, {
    group = auMygroup,
    pattern = { 'typescript', 'json' },
    command = 'setl formatexpr=CocAction("formatSelected")',
})
vim.api.nvim_create_autocmd({ 'User' }, {
    group = auMygroup,
    pattern = 'CocJumpPlaceholder',
    command = 'call CocActionAsync("showSignatureHelp")',
})

-- Remap <C-f> and <C-b> for scroll float windows/popups.
vim.keymap.set('n', '<C-f>','coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', { silent = true, expr = true, nowait = true })
vim.keymap.set('n', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', { silent = true, expr = true, nowait = true })
vim.keymap.set('i', '<C-f>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', { silent = true, expr = true, nowait = true })
vim.keymap.set('i', '<C-b>', 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', { silent = true, expr = true, nowait = true })
vim.keymap.set('v', '<C-f>', 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', { silent = true, expr = true, nowait = true })
vim.keymap.set('v', '<C-b>', 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', { silent = true, expr = true, nowait = true })

vim.keymap.set('n', '[d', '<Plug>(coc-diagnostic-prev)', { silent = true })
vim.keymap.set('n', ']d', '<Plug>(coc-diagnostic-next)', { silent = true })
vim.keymap.set('n', 'gd', ':call CocAction("jumpDefinition")<CR>', { silent = true })
vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
vim.keymap.set('n', 'gr', '<Plug>(coc-references)', { silent = true })
vim.g.coc_global_extensions = { 'coc-json', 'coc-tsserver', 'coc-phpls', 'coc-html', 'coc-prettier', 'coc-css', 'coc-eslint', 'coc-svg', 'coc-sql', 'coc-snippets', '@yaegassy/coc-tailwindcss3' }
-- function! s:show_documentation()
--   if (index(['vim','help'], &filetype) >= 0)
--     execute 'h '.expand('<cword>')
--   elseif (coc#rpc#ready())
--     call CocActionAsync('doHover')
--   else
--     execute '!' . &keywordprg . " " . expand('<cword>')
--   endif
-- endfunction

-- Prettier on save
vim.api.nvim_create_user_command('Prettier', ":call CocAction('runCommand', 'prettier.formatFile')", { bang = true, nargs = 0 })
vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
    group = auQuickfix,
    pattern = '*.php',
    command = 'execute "Prettier"',
})
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

-- Fuzzy
vim.g.fzf_vim = {
    layout = { window = { width = 0.9, height = 0.95 } },
    preview_window = { 'up,50%', 'ctrl-/' }
}
local preview_window_options = '--scroll-off=5 --scrollbar "▌▐" --bind "ctrl-l:first" --bind "ctrl-h:last" --bind "ctrl-a:select-all" --bind "ctrl-c:deselect-all" --bind "ctrl-d:preview-half-page-down" --bind "ctrl-u:preview-half-page-up" --bind "ctrl-/:change-preview-window(right,70%|down,40%,border-top|hidden|)"'

vim.api.nvim_create_user_command('PRg', 'call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case " . shellescape(<q-args>, 1), 1, fzf#vim#with_preview({"dir": system("git rev-parse --show-toplevel 2> /dev/null")[:-2], "options": \'' .. preview_window_options .. ' --prompt \"Search in files> \"\' }), <bang>0)', { bang = true, nargs = '*' })

vim.api.nvim_create_user_command('CurrentDirFiles', "call fzf#vim#files(<q-args>, fzf#vim#with_preview({ 'dir': expand('%:p:h') , 'options': '" .. preview_window_options .. "' }), <bang>0)", { bang = true, nargs = '*' })

vim.api.nvim_create_user_command('CGFiles', ':call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(<q-args> == "?" ? { "placeholder": "" , "options": \'' .. preview_window_options .. '\' } : {"options": \'' .. preview_window_options .. '\' }, ), <bang>0)', { bang = true, nargs = '?' })

vim.api.nvim_create_user_command('CBuffers', ':call fzf#vim#buffers(<q-args>, fzf#vim#with_preview({ "placeholder": "{1}", "options": \'' .. preview_window_options .. '\' }), <bang>0)', { bang = true, nargs = '?', bar = true, complete = 'buffer' })

vim.keymap.set('i', '<c-x><c-l>', '<plug>(fzf-complete-line)')
vim.keymap.set('n', '<Leader>f', ':CGFiles --exclude-standard --cached --others<CR>', { silent = true })
vim.keymap.set('n', '<Leader>b', ':CBuffers<CR>', { silent = true })
vim.keymap.set('n', '<Leader>o', ':CurrentDirFiles<CR>', { silent = true })
vim.keymap.set('n', '<leader>/', ':exec ":PRg " . escape(input("Search in files: "), "()[]{}$")<CR>', { silent = true })
vim.keymap.set('v', '<leader>/', '"cy :exec ":PRg " . escape(getreg("c"), "()[]{}$")<CR>', { silent = true })
vim.keymap.set('i', '<c-x><c-f>', '<plug>(fzf-complete-path)')

-- Markdown
vim.g.mkdp_auto_start = 0
vim.g.mkdp_auto_close = 0
vim.g.mkdp_refresh_slow = 0
vim.g.mkdp_port = 9981

require './theme'
require './git'
require './treesitter'
require './statusbar'
require './delimiters'
require 'colorizer'.setup()
require 'nvim-autopairs'.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})

require('nvim-cursorline').setup {
    cursorline = {
        enable = true,
        timeout = 1000,
        number = false,
    },
    cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
    }
}

require("luasnip.loaders.from_snipmate").lazy_load()
