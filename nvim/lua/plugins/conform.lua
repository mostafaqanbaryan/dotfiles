return {
	"stevearc/conform.nvim",
	event = { "BufWritePre" },
	cmd = { "ConformInfo" },
	-- Everything in opts will be passed to setup()
	opts = {
		-- Define your formatters
		formatters_by_ft = {
			lua = { "stylua" },
			scss = { "prettier", stop_after_first = true },
			python = { "isort", "black", stop_after_first = true },
			javascript = { "prettier", stop_after_first = true },
			typescript = { "prettier", stop_after_first = true },
			typescriptreact = { "prettier", stop_after_first = true },
			javascriptreact = { "prettier", stop_after_first = true },
			php = { "php_cs_fixer", "prettier", stop_after_first = true },
		},
		-- Customize formatters
		formatters = {
			shfmt = {
				prepend_args = { "-i", "2" },
			},
		},
	},
	init = function()
		require("conform").setup()

		-- If you want the formatexpr, here is the place to set it
		vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
	end,
}
