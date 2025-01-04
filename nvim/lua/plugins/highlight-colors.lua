return {
    'brenoprata10/nvim-highlight-colors',
    event = 'VeryLazy',
    config = function()
        require("nvim-highlight-colors").setup({
            enable_tailwind = true,
        })
    end
}
