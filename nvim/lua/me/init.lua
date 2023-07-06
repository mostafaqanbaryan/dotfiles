require "hardtime".setup({ disabled_filetypes = { "gitcommit", "fugitive", "qf", "netrw", "NvimTree", "lazy", "mason" } })
require 'colorizer'.setup()
require 'neoscroll'.setup()
require 'nvim-autopairs'.setup()
require 'me.toggleterm'
require 'me.gitsigns'
require 'me.treesitter'
require 'me.statusbar'
require 'me.navigator'
require "mason-lspconfig".setup()
require "mason".setup()
require 'me.fold'
require 'me.lsp'
-- require 'leap'.add_default_mappings()

