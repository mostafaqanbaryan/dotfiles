return {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    dependencies = {
        { 'rafamadriz/friendly-snippets' },
        {
            "edte/blink-go-import.nvim",
            ft = "go",
            config = function()
                require("blink-go-import").setup()
            end
        }
    },
    version = '*',

    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
        signature = { enabled = true },
        keymap = {
            ['<C-u>'] = { 'scroll_documentation_up', 'fallback' },
            ['<C-d>'] = { 'scroll_documentation_down', 'fallback' },
        },
        completion = {
            accept = { auto_brackets = { enabled = true }, },
            documentation = { auto_show = true, auto_show_delay_ms = 100 },
            ghost_text = { enabled = false },
            list = {
                selection = { preselect = false, auto_insert = true }
            }
        },

        -- Default list of enabled providers defined so that you can extend it
        -- elsewhere in your config, without redefining it, due to `opts_extend`
        sources = {
            default = { 'lsp', 'path', 'snippets', 'buffer', 'go_pkgs' },
            providers = {
                go_pkgs = {
                    module = "blink-go-import",
                    name = "Import",
                }
            },
            cmdline = {}
        },
    },
    opts_extend = { "sources.default" }
}
