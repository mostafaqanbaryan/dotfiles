return {
    'neovim/nvim-lspconfig',
    lazy = false,
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'williamboman/mason-lspconfig.nvim' },
    },
    config = function()
        local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
        for type, icon in pairs(signs) do
            local hl = "DiagnosticSign" .. type
            vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
        end

        -- Show source in diagnostics
        vim.diagnostic.config({
            update_in_insert = true,
            severity_sort = true,
            virtual_text = false,
            float = {
                source = true
            },
        })

        -- Remove background of virtual text
        local table = vim.api.nvim_get_hl(0, { name = 'DiagnosticVirtualTextError' })
        local newTable = vim.tbl_extend("force", table, { bg = "NONE", ctermbg = "NONE" })
        vim.api.nvim_set_hl(0, 'DiagnosticVirtualTextError', newTable);

        -- This is where all the LSP shenanigans will live
        local lsp_zero = require('lsp-zero')
        lsp_zero.extend_lspconfig()

        --- if you want to know more about lsp-zero and mason.nvim
        --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
        lsp_zero.on_attach(function(client, bufnr)
            -- see :help lsp-zero-keybindings
            -- to learn the available actions
            lsp_zero.default_keymaps({ buffer = bufnr })
            vim.api.nvim_create_autocmd('CursorHold', {
                pattern = "*",
                callback = function()
                    vim.diagnostic.open_float(0, {
                        scope = 'cursor',
                        focusable = false,
                        close_events = {
                            'CursorMoved',
                            'CursorMovedI',
                            'BufHidden',
                            'InsertCharPre',
                            'WinLeave',
                        }
                    })
                end
            })
        end)

        require('mason-lspconfig').setup({
            lazy = false,
            ensure_installed = { "intelephense", "tsserver", "lua_ls" },
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
