return {
    'mhinz/vim-startify',
    lazy = false,
    branch = 'master',
    config = function()
        -- Start from 1
        vim.g.startify_custom_indices      = vim.cmd("map(range(1,100), 'string(v:val)')")
        vim.g.startify_session_sort        = 1
        vim.g.startify_session_number      = 10
        vim.g.startify_session_persistence = 1
        vim.g.startify_session_autoload    = 1
        vim.g.startify_session_dir         = vim.fn.stdpath("state") .. "/sessions/"
        vim.g.startify_relative_path       = 0
        vim.g.startify_change_to_dir       = 0

        vim.g.startify_commands            = {
            { c = { 'Open Configs', ':Config' } }
        }
        vim.g.startify_lists               = {
            { type = 'commands',  header = { '   [Commands]' } },
            { type = 'files',     header = { '   [Files]' } },
            { type = 'dir',       header = { '   [Directory] ' .. vim.fn.getcwd() } },
            { type = 'sessions',  header = { '   [Sessions]' } },
            { type = 'bookmarks', header = { '   [Bookmarks]' } },
        }
        vim.g.startify_custom_header       = {
            "   ____    __    ____  __    ______  __  ___  ____    _______       ___        ______  _______ ",
            "   \\   \\  /  \\  /   / |  |  /      ||  |/  / |___ \\  |       \\     /   \\      /      ||   ____|",
            "    \\   \\/    \\/   /  |  | |  ,----'|  '  /    __) | |  .--.  |   /  ^  \\    |  ,----'|  |__   ",
            "     \\            /   |  | |  |     |    <    |__ <  |  |  |  |  /  /_\\  \\   |  |     |   __|  ",
            "      \\    /\\    /    |  | |  `----.|  .  \\   ___) | |  '--'  | /  _____  \\  |  `----.|  |____ ",
            "       \\__/  \\__/     |__|  \\______||__|\\__\\ |____/  |_______/ /__/     \\__\\  \\______||_______|",
            "                                                                                               ",

        }
    end
}
