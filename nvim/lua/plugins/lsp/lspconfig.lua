local function setup_format_on_save()
	vim.g.disable_autoformat = false

	local formatter_group = vim.api.nvim_create_augroup("formatter_au", { clear = true })

	for _, name in ipairs({
		"source.addMissingImports.ts",
		"source.removeUnused.ts",
		-- "source.organizeImports",
		-- "source.fixAll.eslint",
	}) do
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.tsx", "*.ts", "*.jsx", "*.js" },
			group = formatter_group,
			callback = function()
				if vim.g.disable_autoformat then
					return
				end
				vim.lsp.buf.code_action({ apply = true, context = { only = { name }, diagnostics = {} } })
			end,
		})
	end

	-- Autoimport and sort imports in go files
	-- https://go.dev/gopls/editor/vim#neovim-imports
	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*.go",
		group = formatter_group,
		callback = function()
			if vim.g.disable_autoformat then
				return
			end
			local params = vim.lsp.util.make_range_params()
			params.context = { only = { "source.organizeImports" } }
			-- buf_request_sync defaults to a 1000ms timeout. Depending on your
			-- machine and codebase, you may want longer. Add an additional
			-- argument after params if you find that you have to write the file
			-- twice for changes to be saved.
			-- E.g., vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 3000)
			local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params)
			for cid, res in pairs(result or {}) do
				for _, r in pairs(res.result or {}) do
					if r.edit then
						local enc = (vim.lsp.get_client_by_id(cid) or {}).offset_encoding or "utf-16"
						vim.lsp.util.apply_workspace_edit(r.edit, enc)
					end
				end
			end
		end,
	})

	vim.api.nvim_create_autocmd("BufWritePre", {
		pattern = "*",
		group = formatter_group,
		callback = function(args)
			if vim.g.disable_autoformat then
				return
			end
			require("conform").format({ bufnr = args.buf, timeout_ms = 5000 })
		end,
	})

	vim.api.nvim_create_user_command("FormatterDisable", function(args)
		vim.g.disable_autoformat = true
	end, {
		desc = "Disable autoformat-on-save",
	})

	vim.api.nvim_create_user_command("FormatterEnable", function(args)
		vim.g.disable_autoformat = false
	end, {
		desc = "Enable autoformat-on-save",
	})
end

return {
	"neovim/nvim-lspconfig",
	lazy = false,
	config = function()
		vim.lsp.config("gopls", {
			settings = {
				gopls = {
					completeUnimported = true,
					usePlaceholders = true,
					deepCompletion = true,
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

		vim.lsp.config("lua_ls", {
			settings = {
				Lua = {
					diagnostics = {
						globals = { "vim" },
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

				vim.lsp.on_type_formatting.enable()

				setup_format_on_save(args)

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

				vim.keymap.set("n", "<leader>;", function()
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
