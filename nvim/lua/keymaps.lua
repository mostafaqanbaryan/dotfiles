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
vim.keymap.set('n', 'ga', '<C-^>')

-- Working with split
vim.keymap.set('n', '<C-j>', '<C-W>j')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-l>', '<C-W>l')
vim.keymap.set('n', '<C-h>', '<C-W>h')
vim.keymap.set('n', '<C-<>', '<C-W>> " Increase split size')
vim.keymap.set('n', '<C->>', '<C-W>< " Decrease split size')

-- remap movement to move by column layout
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

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

vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-f>', '<C-f>zz')
vim.keymap.set('n', '<C-b>', '<C-b>zz')

-- Lazygit
vim.keymap.set('n', '<Leader>g', ':silent exec "!zellij action new-pane --name Lazygit -c -f -- lazygit"<CR>',
    { silent = true })
