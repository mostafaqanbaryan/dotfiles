-- Creating snippets on the fly
return {
    "chrisgrieser/nvim-scissors",
    dependencies = "nvim-telescope/telescope.nvim",
    cmd = { "ScissorsAddNewSnippet", "ScissorsEditSnippet" },
    opts = {
        snippetDir = vim.fn.stdpath("config") .. "/snippets",
    }
}
