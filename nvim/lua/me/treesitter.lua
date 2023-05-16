require'nvim-treesitter.configs'.setup {
    ensure_installed = { "html", "scss", "php", "graphql", "typescript", "javascript", "tsx", "vim" },
    sync_install = true,
    auto_install = true,
    highlight = {
        enable = true
    }
}

require 'treesitter-context'.setup{
    enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
    max_lines = 3, -- How many lines the window should span. Values <= 0 mean no limit.
    trim_scope = 'outer', -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
    patterns = { -- Match patterns for TS nodes. These get wrapped to match at word boundaries.
        default = {
            'class',
            'function',
            'method',
            'for',
            'if',
        },
    },
    zindex = 20, -- The Z-index of the context window
    mode = 'cursor',  -- Line used to calculate context. Choices: 'cursor', 'topline'
}
