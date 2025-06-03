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

-- Unimpaired bindings
vim.keymap.set("n", "[e", '"uddk"uP')
vim.keymap.set("n", "]e", '"udd"up')

-- Close quickfix with ESC/q
vim.api.nvim_create_autocmd({ "FileType" }, {
	pattern = "qf",
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "<ESC>", "<cmd>q<CR>", { silent = true, noremap = true })
		vim.api.nvim_buf_set_keymap(0, "n", "q", "<cmd>q<CR>", { silent = true, noremap = true })
	end,
})

-- Send text to popup
vim.keymap.set("v", "<leader>pp", function()
	vim.print("notify-send '" .. get_visual_selection() .. "'")
	print(os.execute("notify-send '" .. get_visual_selection() .. "'"))
end)

-- https://github.com/ibhagwan/fzf-lua/blob/f7f54dd685cfdf5469a763d3a00392b9291e75f2/lua/fzf-lua/utils.lua#L372
function get_visual_selection()
	-- this will exit visual mode
	-- use 'gv' to reselect the text
	local _, csrow, cscol, cerow, cecol
	local mode = vim.fn.mode()
	if mode == "v" or mode == "V" or mode == "" then
		-- if we are in visual mode use the live position
		_, csrow, cscol, _ = unpack(vim.fn.getpos("."))
		_, cerow, cecol, _ = unpack(vim.fn.getpos("v"))
		if mode == "V" then
			-- visual line doesn't provide columns
			cscol, cecol = 0, 999
		end
		-- exit visual mode
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
	else
		-- otherwise, use the last known visual position
		_, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
		_, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
	end
	-- swap vars if needed
	if cerow < csrow then
		csrow, cerow = cerow, csrow
	end
	if cecol < cscol then
		cscol, cecol = cecol, cscol
	end
	local lines = vim.fn.getline(csrow, cerow)
	-- local n = cerow-csrow+1
	local n = tbl_length(lines)
	if n <= 0 then
		return ""
	end
	lines[n] = string.sub(lines[n], 1, cecol + 1)
	lines[1] = string.sub(lines[1], cscol)
	local content = table.concat(lines, "\n")

	return string.gsub(content, "[^a-zA-Z0-9 %z\32\226\128\128-\226\128\143\226\128\168-\226\128\175]", "")
end

function tbl_length(T)
	local count = 0
	for _ in pairs(T) do
		count = count + 1
	end
	return count
end
