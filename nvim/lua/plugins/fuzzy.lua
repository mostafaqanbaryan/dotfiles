return {
    'ibhagwan/fzf-lua',
    branch = 'main',
    cmd = { 'CGFiles', 'CBuffers', 'CurrentDirFiles' },
    keys = {
        { '<Leader>f',   '<cmd>lua require("fzf-lua").git_files()<CR>',                                                           { silent = true } },
        { '<Leader>b',   '<cmd>lua require("fzf-lua").buffers()<CR>',                                                             { silent = true } },
        { '<Leader>o',   '<cmd>lua require("fzf-lua").files({ cwd = vim.fn.expand("%:p:h")})<CR>',                                { silent = true } },
        { '<Leader>/iw', '<cmd>lua require("fzf-lua").grep_cword()<CR>',                                                          { silent = true } },
        { '<Leader>/iW', '<cmd>lua require("fzf-lua").grep_cWORD()<CR>',                                                          { silent = true } },
        { '<Leader>//',  '<cmd>lua require("fzf-lua").grep()<CR>',                                                                { silent = true } },
        -- { '<Leader>//',  '<cmd>lua require("fzf-lua").grep_visual()<CR>',                                                         { silent = true, mode = 'v' } },
        { '<F4>',        '<cmd>lua require("fzf-lua").lsp_code_actions({ winopts = { preview = { layout = "horizontal" }}})<CR>', { silent = true } },
    },
    dependencies = {
        { 'nvim-tree/nvim-web-devicons' },
        { 'junegunn/fzf',               branch = 'master', build = "./install --bin" },
    },
    config = function()
        -- calling `setup` is optional for customization
        require("fzf-lua").setup({
            winopts = {
                width = 0.9,
                height = 0.95,
                preview = {
                    scrolloff = 5,
                    scrollbar = "▌▐",
                    preview   = "wrap",
                    layout    = "vertical",
                    vertical  = 'up:50%',
                },
                on_create = function()
                    vim.keymap.set("t", "<C-k>", "<S-up>", { silent = true, buffer = true, remap = true })
                    vim.keymap.set("t", "<C-j>", "<S-down>", { silent = true, buffer = true, remap = true })
                end
            },
            keymap = {
                fzf = {
                    ["ctrl-l"] = "first",
                    ["ctrl-h"] = "last",
                    ["ctrl-a"] = "select-all",
                    ["ctrl-c"] = "deselect-all",
                }
            },
            git = {
                files = {
                    cmd = 'git ls-files --exclude-standard --cached --others'
                }
            }
        })
    end
}
