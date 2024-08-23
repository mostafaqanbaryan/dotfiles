return {
    "lukas-reineke/indent-blankline.nvim",
    lazy = false,
    main = "ibl",
    opts = {},
    init = function()
        require("ibl").setup({
            indent = {
                tab_char = '▍'
            }
        })
    end
}
