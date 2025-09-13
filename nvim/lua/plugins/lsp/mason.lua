return {
	"williamboman/mason.nvim",
	lazy = false,
	dependencies = {
		"WhoIsSethDaniel/mason-tool-installer.nvim",
		"williamboman/mason-lspconfig.nvim",
		"jay-babu/mason-nvim-dap.nvim",
	},
	config = function()
		local mason = require("mason")

		local mason_tool_installer = require("mason-tool-installer")

		-- enable mason and configure icons
		mason.setup({
			ui = {
				icons = {
					package_installed = "✓",
					package_pending = "➜",
					package_uninstalled = "✗",
				},
			},
		})

		mason_tool_installer.setup({
			ensure_installed = {
				"staticcheck", -- go linter
				"prettier", -- prettier formatter
				"stylua", -- lua formatter
				"gofumpt", -- go formatter
				"goimports", -- go formatter
				"goimports-reviser", -- go formatter
				"eslint", -- js linter
			},
		})

		require("mason-nvim-dap").setup({
			ensure_installed = { "php-debug-adaptor", "delve" },
			automatic_installation = true,
		})

		require("mason-lspconfig").setup({
			lazy = false,
			automatic_installation = true,
			ensure_installed = {
				"intelephense",
				"vtsls",
				"lua_ls",
				"eslint",
				"gopls",
				"bashls",
				"harper_ls",
			},
		})
	end,
}
