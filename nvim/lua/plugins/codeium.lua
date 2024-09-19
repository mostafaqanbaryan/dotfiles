return {
    'Exafunction/codeium.vim',
    lazy = false,
    config = function()
        vim.keymap.set('i', '<C-c>a', function() return vim.fn['codeium#Accept']() end, { expr = true, silent = true })
        vim.keymap.set('i', '<c-c>n', function() return vim.fn['codeium#CycleCompletions'](1) end,
            { expr = true, silent = true })
        vim.keymap.set('i', '<c-c>p', function() return vim.fn['codeium#CycleCompletions'](-1) end,
            { expr = true, silent = true })
        vim.keymap.set('i', '<c-c>c', function() return vim.fn['codeium#Clear']() end, { expr = true, silent = true })

        vim.keymap.set('i', '<c-c>y', function() return vim.fn['codeium#CycleOrComplete']() end,
            { expr = true, silent = true })

        vim.g.codeium_enabled = true
        vim.g.codeium_render = true
    end
}
