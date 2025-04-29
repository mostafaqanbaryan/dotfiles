return {
	"neovim/nvim-lspconfig",
	lazy = false,
	config = function()
		vim.lsp.config("gopls", {
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

		-- LSP
		vim.diagnostic.config({
			severity_sort = true,
			virtual_text = false,
			float = {
				focusable = true,
				source = true,
				border = "rounded",
				scope = "cursor",
			},
			jump = {
				float = {
					focusable = true,
					source = true,
					border = "rounded",
					scope = "cursor",
				},
			},
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
			"pylsp",
			"lua_ls",
			"gopls",
			"php_ls",
		})

		vim.filetype.add({
			extension = {
				env = "sh",
			},
			filename = {
				[".env"] = "sh",
			},
			pattern = {
				[".env.[%w]+"] = "sh",
			},
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

				vim.keymap.set("n", ";", function()
					-- If we find a floating window, close it.
					local found_float = false
					for _, win in ipairs(vim.api.nvim_list_wins()) do
						local l = vim.api.nvim_win_get_config(win)
						if l.relative ~= "" and l.focusable then
							vim.api.nvim_win_close(win, true)
							found_float = true
						end
					end

					if not found_float then
						vim.diagnostic.open_float()
					end
				end, { silent = true })
			end,
		})
	end,
}
