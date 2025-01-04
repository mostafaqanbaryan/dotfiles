return {
    'tpope/vim-unimpaired',
    branch = 'master',
    event = 'VeryLazy',
    init = function()
        vim.keymap.set('n', ']D',
            '<cmd>lua vim.diagnostic.goto_next( {severity=vim.diagnostic.severity.ERROR, wrap = true} )<CR>',
            { silent = true })
        vim.keymap.set('n', '[D',
            '<cmd>lua vim.diagnostic.goto_prev( {severity=vim.diagnostic.severity.ERROR, wrap = true} )<CR>',
            { silent = true })
    end
}
