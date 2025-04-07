-- clear search
vim.keymap.set("n", "<esc>", "<cmd>noh<cr><esc>", { silent = true, desc = "Escape and Clear hlsearch" })

-- Remap paste
vim.keymap.set("v", "p", "P")
vim.keymap.set("v", "P", "p")

-- Copy/Paste outside vim
vim.keymap.set("n", "<Leader>yiw", '"+yiw:echo "Copied <iword> to clipboard!"<CR>', { silent = true })
vim.keymap.set("n", "<Leader>yiW", '"+yiW:echo "Copied <IWORD> to clipboard!"<CR>', { silent = true })
vim.keymap.set("n", '<Leader>yi"', '"+yi":echo "Copied sentence to clipboard!"<CR>', { silent = true })
vim.keymap.set("n", "<Leader>yi'", '"+yi\':echo "Copied sentence to clipboard!"<CR>', { silent = true })
vim.keymap.set("n", "<Leader>yi(", '"+yi(:echo "Copied sentence to clipboard!"<CR>', { silent = true })
vim.keymap.set("n", "<Leader>yi)", '"+yi(:echo "Copied sentence to clipboard!"<CR>', { silent = true })
vim.keymap.set("n", "<Leader>yi[", '"+yi[:echo "Copied sentence to clipboard!"<CR>', { silent = true })
vim.keymap.set("n", "<Leader>yi]", '"+yi[:echo "Copied sentence to clipboard!"<CR>', { silent = true })
vim.keymap.set("n", "<Leader>yi{", '"+yi{:echo "Copied sentence to clipboard!"<CR>', { silent = true })
vim.keymap.set("n", "<Leader>yi}", '"+yi{:echo "Copied sentence to clipboard!"<CR>', { silent = true })
vim.keymap.set("n", "<Leader>yy", '"+yy:echo "Copied line to clipboard!"<CR>', { silent = true })
vim.keymap.set("v", "<Leader>y", '"+y:echo "Selection yanked to clipboard!"<CR>', { silent = true })

-- Copy full address
vim.keymap.set("n", "<Leader>yp", ':let @+=expand("%")<CR>:echo "Filepath yanked to clipboard!"<CR>', { silent = true })

-- Toggle between 2 last files
vim.keymap.set("n", "ga", "<C-^>")

-- Working with split
vim.keymap.set("n", "<C-<>", '<C-W>> " Increase split size')
vim.keymap.set("n", "<C->>", '<C-W>< " Decrease split size')

-- remap movement to move by column layout
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })

-- Title as filename
vim.opt.title = true

-- Search in VisualMode
vim.keymap.set("v", "/", 'y/<C-R>"<CR>')

-- Replace word under cursor
vim.keymap.set("n", "cu", ":%s/\\(<C-R><C-W>\\)//cg<Left><Left><Left>")

-- Go to last buffer and delete the current one
vim.keymap.set("n", "<Leader>c", ":bnext<CR>:bwipeout#<CR>", { silent = true })

-- Clean slate
vim.keymap.set("n", "<leader>n", "<cmd>bufdo bd<CR>", { silent = true })

-- Center cursor of half/full page up/down
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-f>", "<C-f>zz")
vim.keymap.set("n", "<C-b>", "<C-b>zz")

-- Avoid x and s to override register
vim.keymap.set("n", "x", '"_x')
vim.keymap.set("n", "X", '"_X')
vim.keymap.set("n", "s", '"_s')
