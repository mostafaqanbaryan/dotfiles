return {
    'iamcco/markdown-preview.nvim',
    branch = 'master',
    build = 'cd app && yarn install',
    ft = 'markdown',
    config = function()
        vim.g.mkdp_auto_start = 0
        vim.g.mkdp_auto_close = 0
        vim.g.mkdp_refresh_slow = 0
        vim.g.mkdp_port = 9981
    end
}
