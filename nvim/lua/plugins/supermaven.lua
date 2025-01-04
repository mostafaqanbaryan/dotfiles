return {
    "supermaven-inc/supermaven-nvim",
    event = 'VeryLazy',
    config = function()
        require("supermaven-nvim").setup({})
    end,
}
