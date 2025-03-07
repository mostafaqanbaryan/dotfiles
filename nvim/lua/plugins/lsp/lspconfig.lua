return {
	"folke/neodev.nvim",
	cmd = { "LspInfo", "LspInstall", "LspStart" },
	event = { "BufReadPre", "BufNewFile" },
	dependencies = {
		{ "williamboman/mason-lspconfig.nvim" },
		{ "neovim/nvim-lspconfig" },
		{ "nvimdev/lspsaga.nvim" },
	},
	config = function()
		-- neodev must be initialized before lspconfig
		require("neodev").setup()
		require("lspsaga").setup({
			ui = {
				enable = false,
			},
			symbol_in_winbar = {
				enable = false,
			},
			lightbulb = {
				enable = false,
			},
		})

		local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
		for type, icon in pairs(signs) do
			local hl = "DiagnosticSign" .. type
			vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
		end

		-- Show source in diagnostics
		vim.diagnostic.config({
			update_in_insert = false,
			severity_sort = true,
			virtual_text = false,
			float = false,
		})

		-- Remove background of virtual text
		local table = vim.api.nvim_get_hl(0, { name = "DiagnosticVirtualTextError" })
		local newTable = vim.tbl_extend("force", table, { bg = "NONE", ctermbg = "NONE" })
		vim.api.nvim_set_hl(0, "DiagnosticVirtualTextError", newTable)

		-- This is where all the LSP shenanigans will live
		local lsp_zero = require("lsp-zero")
		lsp_zero.extend_lspconfig()

		--- if you want to know more about lsp-zero and mason.nvim
		--- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
		lsp_zero.on_attach(function(client, bufnr)
			if client.server_capabilities.inlayHintProvider then
				vim.lsp.inlay_hint.enable(true)
			end

			-- LSPSaga
			vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", { silent = true, buffer = true, remap = true })
			vim.keymap.set(
				"n",
				"gd",
				"<cmd>Lspsaga goto_definition<CR>",
				{ silent = true, buffer = true, remap = true }
			)
			vim.keymap.set(
				"n",
				"grp",
				"<cmd>Lspsaga peek_definition<CR>",
				{ silent = true, buffer = true, remap = true }
			)
			vim.keymap.set("n", "gra", "<cmd>Lspsaga code_action<CR>", { silent = true, buffer = true, remap = true })
			vim.keymap.set("n", "grn", "<cmd>Lspsaga rename<CR>", { silent = true, buffer = true, remap = true })
			vim.keymap.set("n", "grr", "<cmd>Lspsaga finder ref<CR>", { silent = true, buffer = true, remap = true })
			vim.keymap.set("n", "gri", "<cmd>Lspsaga finder imp<CR>", { silent = true, buffer = true, remap = true })
			vim.keymap.set(
				"n",
				"]d",
				"<cmd>Lspsaga diagnostic_jump_next<CR>",
				{ silent = true, buffer = true, remap = true }
			)
			vim.keymap.set(
				"n",
				"[d",
				"<cmd>Lspsaga diagnostic_jump_prev<CR>",
				{ silent = true, buffer = true, remap = true }
			)
			vim.keymap.set("n", "]D", function()
				require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
			end, { silent = true, buffer = true, remap = true })
			vim.keymap.set("n", "[D", function()
				require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
			end, { silent = true, buffer = true, remap = true })

			-- See :help lsp-zero-keybindings
			-- to learn the available actions
			lsp_zero.default_keymaps({ buffer = bufnr })
		end)

		-- for neodev
		local lspconfig = require("lspconfig")
		lspconfig.lua_ls.setup({
			settings = {
				Lua = {
					completion = {
						callSnippet = "Replace",
					},
				},
			},
		})

		-- Fixed `use of internal package ... not allowed` incorrect error
		lspconfig.gopls.setup({
			cmd = { "gopls" },
			settings = {
				gopls = {
					analyses = {
						unusedparams = true,
						shadow = true,
						nilness = true,
						unusedwrite = true,
						useany = true,
					},
					staticcheck = true, -- Enable staticcheck
					codelenses = {
						generate = true,
						gc_details = true,
						test = true,
					},
					hints = {
						assignVariableTypes = false,
						compositeLiteralFields = true,
						constantValues = true,
						functionTypeParameters = true,
						parameterNames = true,
						rangeVariableTypes = true,
					},
				},
			},
		})
		-- lsp zero mason
		require("mason-lspconfig").setup({
			lazy = false,
			automatic_installation = true,
			ensure_installed = { "intelephense", "vtsls", "lua_ls", "eslint_d", "gopls", "bashls", "harper_ls" },
			handlers = {
				lsp_zero.default_setup,
				lua_ls = function()
					-- (Optional) Configure lua language server for neovim
					local lua_opts = lsp_zero.nvim_lua_ls()
					require("lspconfig").lua_ls.setup(lua_opts)
				end,
			},
		})
	end,
}
