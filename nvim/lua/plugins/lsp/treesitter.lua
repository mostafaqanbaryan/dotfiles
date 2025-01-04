return {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    branch = 'master',
    build = ':TSUpdate',
    dependencies = {
        { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'master' },
        -- Fix class/function name at top
        { 'nvim-treesitter/nvim-treesitter-context',     branch = 'master' },
        { 'briangwaltney/paren-hint.nvim',               branch = 'main' },
    },
    config = function()
        require 'nvim-treesitter.configs'.setup {
            ensure_installed = { "html", "scss", "php", "graphql", "typescript", "javascript", "tsx", "vim" },
            sync_install = true,
            auto_install = true,
            autotag = {
                enable = true,
            },
            indent = {
                enable = true,
            },
            highlight = {
                enable = true,
            },
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ['aa'] = '@parameter.outer',
                        ['ia'] = '@parameter.inner',
                        ['af'] = '@function.outer',
                        ['if'] = '@function.inner',
                        ['ac'] = '@class.outer',
                        ['ic'] = '@class.inner',
                    }
                },
                move = {
                    enable = true,
                    set_jumps = true,
                    goto_next_start = {
                        [']m'] = '@function.outer',
                        [']]'] = '@class.outer'
                    },
                    goto_next_end = {
                        [']M'] = '@function.outer',
                        [']['] = '@class.outer'
                    },
                    goto_previous_start = {
                        ['[m'] = '@function.outer',
                        ['[['] = '@class.outer'
                    },
                    goto_previous_end = {
                        ['[M'] = '@function.outer',
                        ['[]'] = '@class.outer'
                    },
                },
                swap = {
                    enable = true,
                    swap_next = {
                        [']a'] = '@parameter.inner',
                    },
                    swap_previous = {
                        ['[a'] = '@parameter.inner',
                    }
                }
            }
        }

        require 'treesitter-context'.setup {
            enable = true,        -- Enable this plugin (Can be enabled/disabled later via commands)
            max_lines = 3,        -- How many lines the window should span. Values <= 0 mean no limit.
            trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
            patterns = {          -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
                default = {
                    'class',
                    'function',
                    'method',
                    'for',
                    'foreach',
                    'if',
                },
            },
            zindex = 20,     -- The Z-index of the context window
            mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
        }

        -- Jumping to context (upwards)
        vim.keymap.set("n", "[c", function()
            require("treesitter-context").go_to_context(vim.v.count1)
        end, { silent = true })
    end
}
