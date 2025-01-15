return {
    'rose-pine/neovim',
    lazy = false,
    priority = 1000,
    config = function()
        -- Sync vim background with terminal to prevent extra spaces (padding) for transparent backgrounds
        vim.api.nvim_create_autocmd({ "UIEnter", "ColorScheme" }, {
            callback = function()
                local normal = vim.api.nvim_get_hl(0, { name = "Normal" })
                if not normal.bg then return end
                io.write(string.format("\027]11;#%06x\027\\", normal.bg))
            end,
        })
        vim.api.nvim_create_autocmd("UILeave", {
            callback = function() io.write("\027]111\027\\") end,
        })

        require("rose-pine").setup({
            variant = "moon",      -- auto, main, moon, or dawn
            dark_variant = "moon", -- main, moon, or dawn
            dim_inactive_windows = false,
            extend_background_behind_borders = true,

            enable = {
                terminal = true,
                legacy_highlights = true, -- Improve compatibility for previous versions of Neovim
                migrations = true,        -- Handle deprecated options automatically
            },

            styles = {
                bold = true,
                italic = true,
                transparency = false,
            },

            groups = {
                border = "muted",
                link = "iris",
                panel = "surface",

                error = "love",
                hint = "iris",
                info = "foam",
                note = "pine",
                todo = "rose",
                warn = "gold",

                git_add = "foam",
                git_change = "rose",
                git_delete = "love",
                git_dirty = "rose",
                git_ignore = "muted",
                git_merge = "iris",
                git_rename = "pine",
                git_stage = "iris",
                git_text = "rose",
                git_untracked = "subtle",

                h1 = "iris",
                h2 = "foam",
                h3 = "rose",
                h4 = "gold",
                h5 = "pine",
                h6 = "foam",
            },

            highlight_groups = {
                Folded = { bg = "none", fg = "muted" }
            },

            before_highlight = function(group, highlight, palette)
            end,
        })

        vim.cmd("colorscheme rose-pine")
    end
}
