return {
    'folke/tokyonight.nvim',
    lazy = false,
    priority = 1000,
    branch = 'main',
    config = function()
        require("tokyonight").setup({
            -- your configuration comes here
            -- or leave it empty to use the default settings
            style = "moon",         -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
            light_style = "day",    -- The theme is used when the background is set to light
            transparent = false,    -- Enable this to disable setting the background color
            terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
            styles = {
                -- Style to be applied to different syntax groups
                -- Value is any valid attr-list value for `:help nvim_set_hl`
                comments = { italic = true },
                keywords = { italic = true },
                functions = {},
                variables = {},
                -- Background styles. Can be "dark", "transparent" or "normal"
                sidebars = "dark",            -- style for sidebars, see below
                floats = "dark",              -- style for floating windows
            },
            sidebars = { "qf", "help" },      -- Set a darker background on sidebar-like windows. For example: `["qf", "vista_kind", "terminal", "packer"]`
            -- day_brightness = 0.3, -- Adjusts the brightness of the colors of the **Day** style. Number between 0 and 1, from dull to vibrant colors
            hide_inactive_statusline = false, -- Enabling this option, will hide inactive statuslines and replace them with a thin border instead. Should work with the standard **StatusLine** and **LuaLine**.
            dim_inactive = false,             -- dims inactive windows
            lualine_bold = false,             -- When `true`, section headers in the lualine theme will be bold

            on_colors = function(colors) end,
            on_highlights = function(highlights, colors) end,
        })
        vim.cmd [[colorscheme tokyonight]]
        vim.cmd [[hi TreesitterContext guibg=#232433]]
        vim.cmd [[hi TreesitterContextLineNumber guifg=#98C379]]
        vim.cmd [[hi Folded guibg=NONE]]
        vim.cmd [[hi Folded guifg=#737aa2]]
        vim.cmd [[hi Folded ctermbg=NONE]]
        vim.cmd [[hi Search guifg=#ff6000]]
    end
}
