require 'toggleterm'.setup({
    open_mapping = [[<Leader>t]],
    insert_mappings = false,
    terminal_mappings = true,
    direction = 'float',
    autochdir = true,
    close_on_exit = true,
    shell = 'fish',
    auto_scroll = true,
    winbar = {
        enabled = false,
        name_formatter = function(term)
            return term.name
        end
    }
})
