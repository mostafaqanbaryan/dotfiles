return {
    'godlygeek/tabular',
    branch = 'master',
    cmd = 'Tabular',
    keys = {
        { '<Leader>=', ':Tab /=<CR> :%retab!<CR>' },
        { '<Leader>:', ':Tab /:<CR> :%retab!<CR>' },
        { '<Leader>,', ':Tab /,<CR> :%retab!<CR>' },
    }
}
