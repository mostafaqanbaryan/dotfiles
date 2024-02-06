require 'me.tokyonight'
require 'me.gitsigns'
require 'me.treesitter'
require 'me.statusbar'
require 'me.delimiters'
require 'me.noice'
require 'colorizer'.setup()
require 'nvim-autopairs'.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})

require('nvim-cursorline').setup {
    cursorline = {
        enable = true,
        timeout = 1000,
        number = false,
    },
    cursorword = {
        enable = true,
        min_length = 3,
        hl = { underline = true },
    }
}

require("luasnip.loaders.from_snipmate").lazy_load()
