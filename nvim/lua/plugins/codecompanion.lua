return {
    "olimorris/codecompanion.nvim",
    event = "VeryLazy",
    dependencies = {
        "nvim-lua/plenary.nvim",
        { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
    },
    config = function()
        require("codecompanion").setup({
            strategies = {
                chat = {
                    adapter = "openai_compatible",
                },
                inline = {
                    adapter = "openai_compatible",
                },
            },
            adapters = {
                openai_compatible = function()
                    return require("codecompanion.adapters").extend("openai", {
                        schema = {
                            model = {
                                default = "gpt-4o",
                            }
                        },
                    })
                end,
            },
        })

        local function keymapOptions(desc)
            return {
                noremap = true,
                silent = true,
                nowait = true,
                desc = "CodeCompanion " .. desc,
            }
        end

        vim.keymap.set("n", "<leader>g", "<cmd>CodeCompanionChat Toggle<CR>", keymapOptions("Toggle Chat"))
        vim.keymap.set("v", "<leader>g", "<cmd>CodeCompanionChat Add<CR>",
            keymapOptions("Toggle Chat and Add Selected Range"))

        -- vim.keymap.set("v", "<leader>gp", ":<C-u>'<,'>GpChatPaste vsplit<cr>",
        --     keymapOptions("Visual Paste to current chat"))
        -- vim.keymap.set("v", "<leader>gm", ":<C-u>'<,'>Minimal<cr>", keymapOptions("Rewrite with Minimal"))
        -- vim.keymap.set("v", "<leader>gr", ":<C-u>'<,'>GpRewrite<cr>", keymapOptions("Visual Rewrite"))
        -- vim.keymap.set("v", "<leader>gi", ":<C-u>'<,'>GpImplement<cr>", keymapOptions("Implement Comment"))
        -- vim.keymap.set({ "v", "n" }, "<leader>gn", "<cmd>GpNewChatWithContext<cr>",
        --     keymapOptions("New Chat with current buffer as context"))
        -- vim.keymap.set({ "n", "i" }, "<leader>gr", "<cmd>GpRewrite<cr>", keymapOptions("Inline Rewrite"))
        -- vim.keymap.set({ "n", "i" }, "<leader>gt", "<cmd>GpChatToggle<cr>", keymapOptions("Toggle Chat"))
    end
}
