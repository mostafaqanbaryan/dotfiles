return {
    'kevinhwang91/nvim-bqf',
    branch = 'main',
    lazy = false,
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
    end
}
