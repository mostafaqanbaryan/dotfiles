require 'colorizer'.setup()
require 'nvim-autopairs'.setup({
    check_ts = true,
    ts_config = {
        lua = {'string'},-- it will not add a pair on that treesitter node
        javascript = {'template_string'},
        java = false,-- don't check treesitter on java
    }
})
require 'me.toggleterm'
require 'me.gitsigns'
require 'me.treesitter'
require 'me.statusbar'
require 'me.navigator'
require 'me.delimiters'
require 'me.tokyonight'

require 'hardtime'.setup({
    disabled_filetypes = { "gitcommit", "fugitive", "qf", "netrw", "NvimTree", "lazy", "mason" },
    allow_different_key = true
})

require("indent_blankline").setup({
    show_current_context = true,
})

