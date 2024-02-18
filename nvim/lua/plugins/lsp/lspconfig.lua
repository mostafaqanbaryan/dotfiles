return {
    'neovim/nvim-lspconfig',
    lazy = false,
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'williamboman/mason-lspconfig.nvim' },
        {
            "folke/trouble.nvim",
            dependencies = { "nvim-tree/nvim-web-devicons" },
            cmd = 'TroubleToggle',
            keys = {
                { '<leader>d', '<cmd>TroubleToggle<CR>' }
            },
            opts = {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
                mode = 'document_diagnostics',
                use_diagnostic_signs = true,
                padding = false,
                auto_open = false,
                auto_close = true,
                auto_fold = true,
                win_config = {
                    border = 'rounded'
                }
            },
        }
    },
    config = function()
        local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        -- Show source in diagnostics
        vim.diagnostic.config({
            virtual_text = {
                source = "always", -- Or "if_many"
                prefix = '●',
            },
            float = {
                source = "always", -- Or "if_many"
            },
        })

        -- This is where all the LSP shenanigans will live
        local lsp_zero = require('lsp-zero')
        lsp_zero.extend_lspconfig()

        --- if you want to know more about lsp-zero and mason.nvim
        --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
        lsp_zero.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp_zero.default_keymaps({ buffer = bufnr })
        end)

        require('mason-lspconfig').setup({
            lazy = false,
            ensure_installed = { "phpactor", "tsserver", "lua_ls" },
            handlers = {
                lsp_zero.default_setup,
                lua_ls = function()
                    -- (Optional) Configure lua language server for neovim
                    local lua_opts = lsp_zero.nvim_lua_ls()
                    require('lspconfig').lua_ls.setup(lua_opts)
                end,
            }
        })
    end
}
