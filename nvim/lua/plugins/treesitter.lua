return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    branch = 'master',
    build = ':TSUpdate',
    dependencies = {
        { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'master' },
        -- Fix class/function name at top
        { 'nvim-treesitter/nvim-treesitter-context',     branch = 'master' },
        -- Indent object
        { 'kiyoon/treesitter-indent-object.nvim',        branch = 'master' },
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
                        [']f'] = '@function.outer'
                    },
                    swap_previous = {
                        ['[a'] = '@parameter.inner',
                        ['[f'] = '@function.outer'
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
            zindex = 20, -- The Z-index of the context window
            mode = 'cursor', -- Line used to calculate context. Choices: 'cursor', 'topline'
        }

        require("treesitter_indent_object").setup()

        vim.keymap.set({ "x", "o" }, "ai", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer()<CR>")
        vim.keymap.set({ "x", "o" }, "aI",
            "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_outer(true)<CR>")
        vim.keymap.set({ "x", "o" }, "ii", "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner()<CR>")
        vim.keymap.set({ "x", "o" }, "iI",
            "<Cmd>lua require'treesitter_indent_object.textobj'.select_indent_inner(true)<CR>")
    end
}
