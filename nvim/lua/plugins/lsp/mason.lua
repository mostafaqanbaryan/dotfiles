return {
    'williamboman/mason.nvim',
    lazy = false,
    dependencies = {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    config = function()
        local mason = require("mason")

        local mason_tool_installer = require("mason-tool-installer")

        -- enable mason and configure icons
        mason.setup({
            ui = {
                icons = {
                    package_installed = "✓",
                    package_pending = "➜",
                    package_uninstalled = "✗",
                },
            },
        })

        mason_tool_installer.setup({
            ensure_installed = {
                "staticcheck",       -- go linter
                "prettierd",         -- prettier formatter
                "stylua",            -- lua formatter
                "gofumpt",           -- go formatter
                "goimports",         -- go formatter
                "goimports-reviser", -- go formatter
                "eslint_d",          -- js linter
            },
        })
    end
}
