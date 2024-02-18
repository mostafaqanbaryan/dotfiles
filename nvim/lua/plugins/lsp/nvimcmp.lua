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

        ---@diagnostic disable-next-line: redundant-parameter
        cmp.setup({
            completion = {
                completeopt = 'menu,menuone,noinsert'
            },
            sources = {
                { name = 'path' },
                { name = 'nvim_lsp' },
                { name = 'nvim_lua' },
                { name = 'luasnip' },
                { name = 'buffer',  keyword_length = 2 },
            },
            formatting = lsp_zero.cmp_format(),
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
