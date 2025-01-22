local getRoot = function()
    local root = vim.fs.root(0, { '.git' })
    if not root then
        root = '.'
    end
    return root
end

return {
    "leoluz/nvim-dap-go",
    dependencies = {
        'mfussenegger/nvim-dap',
    },
    ft = 'go',
    config = function()
        require('dap-go').setup {
            delve = {
                path = "dlv",
                initialize_timeout_sec = 20,
                port = "${port}",
                args = {},
                build_flags = {},
                detached = vim.fn.has("win32") == 0,
            },
            dap_configurations = {
                {
                    type = "go",
                    name = "Attach remote",
                    mode = "remote",
                    request = "attach",
                },
                {
                    type = "go",
                    name = "Debug Project (main.go)",
                    request = "launch",
                    program = getRoot() .. "/main.go",
                },
            },
        }
    end
}
