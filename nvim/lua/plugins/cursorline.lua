-- Highlight word under cursor
return {
    'yamatsum/nvim-cursorline',
    lazy = false,
    branch = 'main',
    config = function()
        require('nvim-cursorline').setup {
            cursorline = {
                enable = true,
                timeout = 1000,
                number = false,
            },
            cursorword = {
                enable = true,
                min_length = 3,
                hl = { underline = true },
            }
        }
    end
}
