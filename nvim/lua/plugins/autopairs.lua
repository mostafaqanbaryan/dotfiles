return {
    'windwp/nvim-autopairs',
    event = 'VeryLazy',
    branch = 'master',
    config = function()
        require 'nvim-autopairs'.setup({
            check_ts = true,
            ts_config = {
                lua = { 'string' }, -- it will not add a pair on that treesitter node
                javascript = { 'template_string' },
                java = false,       -- don't check treesitter on java
            }
        })
    end
}
