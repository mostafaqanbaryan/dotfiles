return {
    'sindrets/diffview.nvim',
    branch = 'main',
    cmd = 'DiffviewOpen',
    config = function()
        require("diffview").setup({
            view = {
                merge_tool = {
                    layout = 'diff3_mixed',
                }
            },
            hooks = {
                diff_buf_win_enter = function(bufnr)
                    vim.cmd [[DiffviewToggleFiles]]
                    vim.cmd [[norm <c-w>=]]
                end,
            }
        })
    end
}
