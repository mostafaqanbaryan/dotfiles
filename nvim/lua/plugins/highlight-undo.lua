return {
    'tzachar/highlight-undo.nvim',
    event = 'VeryLazy',
    init = function()
        require('highlight-undo').setup({
            duration = 300,
            undo = {
                hlgroup = 'HighlightUndo',
                mode = 'n',
                lhs = 'u',
                map = 'undo',
                opts = {}
            },
            redo = {
                hlgroup = 'HighlightRedo',
                mode = 'n',
                lhs = '<C-r>',
                map = 'redo',
                opts = {}
            },
            highlight_for_count = true,
        })
    end
}
