return {
    'mhinz/vim-startify',
    lazy = false,
    branch = 'master',
    config = function()
        vim.g.startify_session_dir = '~/.config/nvim/sessions'
    end
}
