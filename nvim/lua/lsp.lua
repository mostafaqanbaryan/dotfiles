-- LSP
vim.diagnostic.config({
	severity_sort = true,
	virtual_lines = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = " ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	},
})

vim.lsp.enable({
	"bash_ls",
	"docker_compose_language_service",
	"rust_analyzer",
	"vtsls",
	"intelephense",
	"harper_ls",
	"eslint",
	"lua_ls",
	"gopls",
	"php_ls",
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if client ~= nil and client:supports_method("textDocument/definition") then
			vim.keymap.set("n", "gd", vim.lsp.buf.definition)
		end

		vim.keymap.set(
			"n",
			"]D",
			"<cmd>lua vim.diagnostic.goto_next( {severity=vim.diagnostic.severity.ERROR, wrap = true} )<CR>",
			{ silent = true }
		)
		vim.keymap.set(
			"n",
			"[D",
			"<cmd>lua vim.diagnostic.goto_prev( {severity=vim.diagnostic.severity.ERROR, wrap = true} )<CR>",
			{ silent = true }
		)
	end,
})
