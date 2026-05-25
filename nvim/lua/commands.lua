vim.api.nvim_create_user_command(
	"Reload",
	":exe 'source ' . stdpath('config') . '/init.lua'",
	{ bang = true, nargs = 0 }
)
vim.api.nvim_create_user_command("Config", function()
	require("fzf-lua").files({ cwd = vim.fn.stdpath("config") .. "/lua" })
end, { bang = true, nargs = 0 })

-- Wordpress
vim.api.nvim_create_user_command("Sass", ":silent exe '!sass ' . expand('%:p') . ' ' . expand('%:p:r') . '.css'", {})

-- Aliases for different file types
vim.api.nvim_create_user_command("JSX", ":set ft = javascript.jsx", {})
vim.api.nvim_create_user_command("JS", ":set ft = javascript", {})
vim.api.nvim_create_user_command("HTML", ":set ft = html", {})
vim.api.nvim_create_user_command("PHP", ":set ft = php", {})
vim.api.nvim_create_user_command("SQL", ":set ft = sql", {})

-- Yank to registers as well
vim.api.nvim_create_autocmd({ "TextYankPost" }, {
	pattern = "*",
	callback = function()
		if vim.v.operator == "y" then
			vim.fn.setreg("9", vim.fn.getreg("8"))
			vim.fn.setreg("8", vim.fn.getreg("7"))
			vim.fn.setreg("7", vim.fn.getreg("6"))
			vim.fn.setreg("6", vim.fn.getreg("5"))
			vim.fn.setreg("5", vim.fn.getreg("4"))
			vim.fn.setreg("4", vim.fn.getreg("3"))
			vim.fn.setreg("3", vim.fn.getreg("2"))
			vim.fn.setreg("2", vim.fn.getreg("1"))
			vim.fn.setreg("1", vim.fn.getreg("0"))
		end
	end,
})

vim.api.nvim_create_user_command("ENV", "silent find **/.env", {})

vim.api.close_all_floating_windows = function()
	local found_float = false
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local l = vim.api.nvim_win_get_config(win)
		if l.relative ~= "" and l.focusable then
			vim.api.nvim_win_close(win, true)
			found_float = true
		end
	end
	return found_float
end
