return {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    commands = {
        "Refactor"
    },
    keys = {
        "<leader>re", "<leader>rE", "<leader>rv", "<leader>rV", "<leader>rb", "<leader>rp", "<leader>rP"
    },
    config = function()
        require("refactoring").setup()
        vim.keymap.set("x", "<leader>re", ":Refactor extract ")
        vim.keymap.set("n", "<leader>rE", ":Refactor inline_func")
        -- vim.keymap.set("x", "<leader>rf", ":Refactor extract_to_file ")


        vim.keymap.set("x", "<leader>rv", ":Refactor extract_var ")
        vim.keymap.set({ "n", "x" }, "<leader>rV", ":Refactor inline_var")

        vim.keymap.set("n", "<leader>rb", ":Refactor extract_block")
        -- vim.keymap.set("n", "<leader>rB", ":Refactor extract_block_to_file")

        -- Print var
        -- Supports both visual and normal mode
        vim.keymap.set({ "x", "n" }, "<leader>rp", function() require('refactoring').debug.print_var() end)

        -- Supports only normal mode
        vim.keymap.set("n", "<leader>rP", function() require('refactoring').debug.cleanup({}) end)
    end,
}
