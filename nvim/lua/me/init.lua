require "hardtime".setup({ disabled_filetypes = { "gitcommit", "fugitive", "qf", "netrw", "NvimTree", "lazy", "mason" } })
require 'colorizer'.setup()
require 'neoscroll'.setup()
require 'nvim-autopairs'.setup()
require 'me.toggleterm'
require 'me.gitsigns'
require 'me.treesitter'
require 'me.statusbar'
require 'me.navigator'
require "mason".setup()

local lspconfig = require('lspconfig')
require "mason-lspconfig".setup({
  ensure_installed = {
    'tsserver',
    'phpactor',
    'eslint',
    'html',
    'cssls'
  }
})
require('mason-lspconfig').setup_handlers({
  function(server)
    lspconfig[server].setup({})
  end,
  ['tsserver'] = function()
    lspconfig.tsserver.setup({
      settings = {
        completions = {
          completeFunctionCalls = true
        }
      }
    })
  end
})
require 'me.fold'
require 'me.lsp'
