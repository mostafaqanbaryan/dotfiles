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
				{ 'saadparwaiz1/cmp_luasnip',     branch = 'master' },
				{ 'rafamadriz/friendly-snippets', branch = 'main' },
				{ 'hrsh7th/cmp-buffer',           branch = 'main' },
				{ 'FelipeLema/cmp-async-path',    branch = 'main' },
				{ 'hrsh7th/cmp-calc',             branch = 'main' },
				{ 'hrsh7th/cmp-nvim-lua',         branch = 'main' },
				{ 'jcha0713/cmp-tw2css',          branch = 'main' },
				{ 'hrsh7th/cmp-cmdline',          branch = 'main' },
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
			completion = {
				completeopt = 'menu,menuone,noinsert'
			},
			sources = cmp.config.sources({
				{ name = 'luasnip' },
				{
					name = 'async_path',
					option = {
						trailing_slash = true,
					}
				},
				{ name = 'nvim_lsp' },
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
						buffer = "[Buffer]",
						nvim_lsp = "[LSP]",
						luasnip = "[LuaSnip]",
						nvim_lua = "[Lua]",
						latex_symbols = "[LaTeX]",
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
			})
		})
	end
}
