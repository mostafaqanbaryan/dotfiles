return {
    'kevinhwang91/nvim-bqf',
    branch = 'main',
    event = 'VeryLazy',
    dependencies = {
        'nvim-treesitter/nvim-treesitter'
    },
    config = function()
        require('bqf').setup({
            func_map = {
                open = 'o',
                openc = '<CR>'
            }
        })
        local palette = require('rose-pine.palette')
        vim.api.nvim_set_hl(0, 'BqfPreviewBorder', { bg = palette.pine, fg = palette.base })
        vim.api.nvim_set_hl(0, 'BqfPreviewTitle', { bg = palette.pine, fg = palette.base })
    end
}
