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
            ['<C-j>'] = { 'snippet_forward', 'fallback' },
            ['<C-k>'] = { 'snippet_backward', 'fallback' },
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
                },
                lsp = {
                    fallbacks = {}
                },
                -- Path completion from cwd instead of current buffer's directory
                path = {
                    opts = {
                        get_cwd = function(_)
                            return vim.fn.getcwd()
                        end,
                    },
                },
                -- Show from all buffers
                buffer = {
                    opts = {
                        get_bufnrs = function()
                            return vim.tbl_filter(function(bufnr)
                                return vim.bo[bufnr].buftype == ''
                            end, vim.api.nvim_list_bufs())
                        end
                    }
                }
            },
        },
        cmdline = {
            enabled = false,
        }
    },
    opts_extend = { "sources.default" }
}
