return {
    'nvimdev/indentmini.nvim',
    lazy = false,
    dependencies = {
        'nvim-tree/nvim-web-devicons',
    },
    config = function()
        require("indentmini").setup({
            exclude = { "startify" },
            -- only_current = true
        })
        local palette = require('rose-pine.palette')
        vim.cmd.highlight('IndentLine guifg=#413f4f') -- palette.muted with a little transparency
        vim.cmd.highlight('IndentLineCurrent guifg=' .. palette.muted)
    end,
}
