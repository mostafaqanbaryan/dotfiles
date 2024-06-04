local kind_icons = {
	Text = "",
	Method = "󰆧",
	Function = "󰊕",
	Constructor = "",
	Field = "󰇽",
	Variable = "󰂡",
	Class = "󰠱",
	Interface = "",
	Module = "",
	Property = "󰜢",
	Unit = "",
	Value = "󰎠",
	Enum = "",
	Keyword = "󰌋",
	Snippet = "",
	Color = "󰏘",
	File = "󰈙",
	Reference = "",
	Folder = "󰉋",
	EnumMember = "",
	Constant = "󰏿",
	Struct = "",
	Event = "",
	Operator = "󰆕",
	TypeParameter = "󰅲",
}

return {
	'hrsh7th/nvim-cmp',
	event = 'InsertEnter',
	dependencies = {
		{
			'L3MON4D3/LuaSnip',
			version = "v2.*",
			build = "make install_jsregexp",
			lazy = false,
			dependencies = {
				{ 'hrsh7th/cmp-nvim-lsp-signature-help', event = "UiEnter", branch = 'main' },
				{ 'saadparwaiz1/cmp_luasnip',            event = "UiEnter", branch = 'master' },
				{ 'SergioRibera/cmp-dotenv',             event = "UiEnter", branch = 'main' },
				{ 'rafamadriz/friendly-snippets',        event = "UiEnter", branch = 'main' },
				{ 'hrsh7th/cmp-buffer',                  event = "UiEnter", branch = 'main' },
				{ 'FelipeLema/cmp-async-path',           event = "UiEnter", branch = 'main' },
				{ 'hrsh7th/cmp-calc',                    event = "UiEnter", branch = 'main' },
				{ 'hrsh7th/cmp-nvim-lua',                event = "UiEnter", branch = 'main' },
				{ 'jcha0713/cmp-tw2css',                 event = "UiEnter", branch = 'main' },
				{ 'hrsh7th/cmp-cmdline',                 event = "UiEnter", branch = 'main' },
				{ 'chrisgrieser/cmp_yanky',              event = "UiEnter", branch = 'main' },
			},
		}
	},
	config = function()
		require("luasnip.loaders.from_vscode").lazy_load()

		-- Here is where you configure the autocompletion settings.
		local lsp_zero = require('lsp-zero')
		lsp_zero.extend_cmp()

		-- And you can configure cmp even more, if you want to.
		local cmp = require('cmp')
		local cmp_action = lsp_zero.cmp_action()
		local cmp_autopairs = require('nvim-autopairs.completion.cmp')

		-- Add parentheses after selecing a function
		cmp.event:on(
			'confirm_done',
			cmp_autopairs.on_confirm_done()
		)

		---@diagnostic disable-next-line: redundant-parameter
		cmp.setup({
			-- This disables suggestions from LSPs and selects the first based on priority
			-- https://github.com/hrsh7th/cmp-nvim-lsp/issues/29
			preselect = cmp.PreselectMode.None,
			completion = {
				completeopt = 'menu,menuone,noinsert'
			},
			sources = cmp.config.sources({
				{ name = 'luasnip',                 priority = 6 },
				{
					name = 'async_path',
					option = {
						trailing_slash = true,
					}
				},
				{ name = 'nvim_lsp',                priority = 10 },
				{ name = 'nvim_lsp_signature_help', priority = 10, },
				{ name = 'nvim_lua' },
				{ name = 'jcha0713/cmp-tw2css' },
				{
					name = 'buffer',
					option = {
						keyword_length = 2,
						get_bufnrs = function()
							return vim.api.nvim_list_bufs()
						end
					}
				},
				{ name = "cmp_yanky" },
				{
					name = "dotenv",
					priority = 9,
				},
			}, {
				{ name = 'calc' },
			}, {
				name = 'cmdline',
				option = {
					ignore_cmds = { 'Man', '!' }
				}
			}),

			formatting = {
				format = function(entry, vim_item)
					-- Kind icons
					vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatenates the icons with the name of the item kind
					-- Source
					vim_item.menu = ({
						luasnip = "[LuaSnip]",
						nvim_lsp = "[LSP]",
						buffer = "[Buffer]",
						nvim_lua = "[Lua]",
						latex_symbols = "[LaTeX]",
						dotenv = "[Env]",
					})[entry.source.name]
					return vim_item
				end
			},

			mapping = cmp.mapping.preset.insert({
				['<C-Space>'] = cmp.mapping.complete(),
				['<C-u>'] = cmp.mapping.scroll_docs(-4),
				['<C-d>'] = cmp.mapping.scroll_docs(4),
				['<C-f>'] = cmp_action.luasnip_jump_forward(),
				['<C-b>'] = cmp_action.luasnip_jump_backward(),
			}),

			view = {
				entries = {
					follow_cursor = true
				}
			}
		})
	end
}
