return {
    'tpope/vim-fugitive',
    branch = 'master',
    keys = {
        { 'g[',        ':diffget //2<CR>' },
        { 'g[',        ':diffget //2<CR>', mode = 'v' },
        { 'g]',        ':diffget //3<CR>' },
        { 'g]',        ':diffget //3<CR>', mode = 'v' },
        { '<Leader>B', ':Git blame<CR>',   { silent = true } },
    },
}
