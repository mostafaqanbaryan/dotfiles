vim.api.shell = '/bin/bash'
vim.loader.enable()

-- <Leader> as <space>
vim.g.mapleader = ' '

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- Faster startup
require("lazy").setup({
    -- Theme
    {
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
    },

    -- Untotree
    {
        'mbbill/undotree',
        cmd = 'UndotreeToggle',
        keys = {
            { '<Leader>u', vim.cmd.UndotreeToggle }
        }
    },

    -- Better notifications
    {
        'folke/noice.nvim',
        lazy = false,
        branch = 'main',
        dependencies = {
            { 'MunifTanjim/nui.nvim', branch = 'main' },
            { 'rcarriga/nvim-notify', branch = 'master' },
        },
        config = function()
            vim.notify = require("notify")
            require("noice").setup({
                lsp = {
                    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                    },
                },
                -- you can enable a preset for easier configuration
                presets = {
                    bottom_search = true,         -- use a classic bottom cmdline for search
                    command_palette = true,       -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false,           -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false,       -- add a border to hover docs and signature help
                },
            })
        end
    },

    -- Highlight word under cursor
    {
        'yamatsum/nvim-cursorline',
        lazy = false,
        branch = 'main',
        config = function()
            require('nvim-cursorline').setup {
                cursorline = {
                    enable = true,
                    timeout = 1000,
                    number = false,
                },
                cursorword = {
                    enable = true,
                    min_length = 3,
                    hl = { underline = true },
                }
            }
        end
    },

    -- Fuzzy
    {
        'ibhagwan/fzf-lua',
        branch = 'main',
        cmd = { 'CGFiles', 'CBuffers', 'CurrentDirFiles' },
        keys = {
            { '<Leader>f', '<cmd>lua require("fzf-lua").git_files()<CR>',                                                           { silent = true } },
            { '<Leader>b', '<cmd>lua require("fzf-lua").buffers()<CR>',                                                             { silent = true } },
            { '<Leader>o', '<cmd>lua require("fzf-lua").files({ cwd = vim.lua.expand("%:p:h")})<CR>',                               { silent = true } },
            { '<Leader>/', '<cmd>lua require("fzf-lua").grep()<CR>',                                                                { silent = true } },
            { '<F4>',      '<cmd>lua require("fzf-lua").lsp_code_actions({ winopts = { preview = { layout = "horizontal" }}})<CR>', { silent = true } },
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
                        vim.keymap.set("t", "<C-k>", "<Up>", { silent = true, buffer = true })
                        vim.keymap.set("t", "<C-j>", "<Down>", { silent = true, buffer = true })
                    end
                },
                keymap = {
                    fzf = {
                        ["ctrl-l"] = "first",
                        ["ctrl-h"] = "last",
                        ["ctrl-a"] = "select-all",
                        ["ctrl-c"] = "deselect-all",
                        -- ["ctrl-k"] = "preview-page-up",
                        -- ["ctrl-j"] = "preview-page-down",
                    }
                },
                git = {
                    files = {
                        cmd = 'git ls-files --exclude-standard --cached --others'
                    }
                }
            })
        end
    },

    -- Markdown
    {
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
    },

    -- Explorer
    {
        "rolv-apneseth/tfm.nvim",
        lazy = false,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        opts = {
            -- TFM to use
            -- Possible choices: "ranger" | "nnn" | "lf" | "vifm" | "yazi" (default)
            file_manager = "yazi",
            -- Replace netrw entirely
            -- Default: false
            replace_netrw = true,
            -- Enable creation of commands
            -- Default: false
            -- Commands:
            --   Tfm: selected file(s) will be opened in the current window
            --   TfmSplit: selected file(s) will be opened in a horizontal split
            --   TfmVsplit: selected file(s) will be opened in a vertical split
            --   TfmTabedit: selected file(s) will be opened in a new tab page
            enable_cmds = false,
            -- Custom keybindings only applied within the TFM buffer
            -- Default: {}
            keybindings = {
                ["<ESC>"] = "q"
            },
            -- Customise UI. The below options are the default
            ui = {
                border = "rounded",
                height = 0.15,
                width = 0.15,
                x = 0.5,
                y = 0.5,
            },
        },
        config = function()
            -- Set keymap so you can open the default terminal file manager (yazi)
            vim.api.nvim_set_keymap("n", "<leader>e", "", {
                noremap = true,
                callback = require("tfm").open,
            })
        end,
    },

    -- Autopairs
    {
        'windwp/nvim-autopairs',
        lazy = false,
        branch = 'master',
        config = function()
            require 'nvim-autopairs'.setup({
                check_ts = true,
                ts_config = {
                    lua = { 'string' }, -- it will not add a pair on that treesitter node
                    javascript = { 'template_string' },
                    java = false,       -- don't check treesitter on java
                }
            })
        end
    },
    { 'alvan/vim-closetag', branch = 'master', ft = 'html' },
    { 'tpope/vim-surround', branch = 'master', lazy = false },
    {
        'HiPhish/rainbow-delimiters.nvim',
        lazy = false,
        branch = 'master',
        config = function()
            local rainbow_delimiters = require 'rainbow-delimiters'

            vim.g.rainbow_delimiters = {
                strategy = {
                    [''] = rainbow_delimiters.strategy['global'],
                    vim = rainbow_delimiters.strategy['local'],
                },
                highlight = {
                    'RainbowDelimiterRed',
                    'RainbowDelimiterYellow',
                    'RainbowDelimiterBlue',
                    'RainbowDelimiterOrange',
                    'RainbowDelimiterGreen',
                    'RainbowDelimiterViolet',
                    'RainbowDelimiterCyan',
                },
            }
        end
    },

    -- LSP
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v3.x',
        config = false,
        init = function()
            -- Disable automatic setup, we are doing it manually
            vim.g.lsp_zero_extend_cmp = 0
            vim.g.lsp_zero_extend_lspconfig = 0
        end,
    },
    {
        'williamboman/mason.nvim',
        lazy = false,
        config = true,
    },
    {
        'neovim/nvim-lspconfig',
        lazy = false,
        cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
        event = { 'BufReadPre', 'BufNewFile' },
        dependencies = {
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'williamboman/mason-lspconfig.nvim' },
            {
                "folke/trouble.nvim",
                dependencies = { "nvim-tree/nvim-web-devicons" },
                cmd = 'TroubleToggle',
                keys = {
                    { '<leader>d', '<cmd>TroubleToggle<CR>' }
                },
                opts = {
                    -- your configuration comes here
                    -- or leave it empty to use the default settings
                    -- refer to the configuration section below
                    mode = 'document_diagnostics',
                    use_diagnostic_signs = true,
                    padding = false,
                    auto_open = false,
                    auto_close = true,
                    auto_fold = true,
                    win_config = {
                        border = 'rounded'
                    }
                },
            }
        },
        config = function()
            local signs = { Error = "󰅚 ", Warn = "󰀪 ", Hint = "󰌶 ", Info = " " }
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
            end

            -- Show source in diagnostics
            vim.diagnostic.config({
                virtual_text = {
                    source = "always", -- Or "if_many"
                    prefix = '●',
                },
                float = {
                    source = "always", -- Or "if_many"
                },
            })

            -- This is where all the LSP shenanigans will live
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_lspconfig()

            --- if you want to know more about lsp-zero and mason.nvim
            --- read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
            lsp_zero.on_attach(function(client, bufnr)
                -- see :help lsp-zero-keybindings
                -- to learn the available actions
                lsp_zero.default_keymaps({ buffer = bufnr })
            end)

            require('mason-lspconfig').setup({
                lazy = false,
                ensure_installed = { "intelephense", "tsserver", "lua_ls" },
                handlers = {
                    lsp_zero.default_setup,
                    lua_ls = function()
                        -- (Optional) Configure lua language server for neovim
                        local lua_opts = lsp_zero.nvim_lua_ls()
                        require('lspconfig').lua_ls.setup(lua_opts)
                    end,
                }
            })
        end
    },

    -- Formatter
    {
        "stevearc/conform.nvim",
        event = { "BufWritePre" },
        cmd = { "ConformInfo" },
        keys = {
            {
                -- Customize or remove this keymap to your liking
                "<F3>",
                function()
                    require("conform").format({ async = true, lsp_fallback = true })
                end,
                mode = "",
                desc = "Format buffer",
            },
        },
        -- Everything in opts will be passed to setup()
        opts = {
            -- Define your formatters
            formatters_by_ft = {
                lua = { "stylua" },
                python = { "isort", "black" },
                javascript = { { "prettierd", "prettier" } },
                php = { { "prettierd", "prettier" } },
            },
            -- Set up format-on-save
            format_on_save = { timeout_ms = 500, lsp_fallback = true },
            -- Customize formatters
            formatters = {
                shfmt = {
                    prepend_args = { "-i", "2" },
                },
            },
        },
        init = function()
            -- If you want the formatexpr, here is the place to set it
            vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"
        end,
    },

    -- Autocompletion
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        dependencies = {
            {
                'L3MON4D3/LuaSnip',
                version = "v2.*",
                build = "make install_jsregexp",
                lazy = false,
                dependencies = {
                    { 'saadparwaiz1/cmp_luasnip',     branch = 'master' },
                    { 'rafamadriz/friendly-snippets', branch = 'main' },
                },
            }
        },
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()

            -- Here is where you configure the autocompletion settings.
            local lsp_zero = require('lsp-zero')
            lsp_zero.extend_cmp()

            -- And you can configure cmp even more, if you want to.
            local cmp = require('cmp')
            local cmp_action = lsp_zero.cmp_action()

            ---@diagnostic disable-next-line: redundant-parameter
            cmp.setup({
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                },
                sources = {
                    { name = 'path' },
                    { name = 'nvim_lsp' },
                    { name = 'nvim_lua' },
                    { name = 'luasnip' },
                    { name = 'buffer',  keyword_length = 2 },
                },
                formatting = lsp_zero.cmp_format(),
                mapping = cmp.mapping.preset.insert({
                    ['<C-Space>'] = cmp.mapping.complete(),
                    ['<C-u>'] = cmp.mapping.scroll_docs(-4),
                    ['<C-d>'] = cmp.mapping.scroll_docs(4),
                    ['<C-f>'] = cmp_action.luasnip_jump_forward(),
                    ['<C-b>'] = cmp_action.luasnip_jump_backward(),
                })
            })
        end
    },

    -- Fix class/function name at top
    {
        'nvim-treesitter/nvim-treesitter',
        lazy = false,
        branch = 'master',
        build = ':TSUpdate',
        dependencies = {
            { 'nvim-treesitter/nvim-treesitter-textobjects', branch = 'master' },
            { 'nvim-treesitter/nvim-treesitter-context',     branch = 'master' },
            { 'kiyoon/treesitter-indent-object.nvim',        branch = 'master' },
        },
        config = function()
            require './treesitter'
        end
    },

    -- Git
    {
        'lewis6991/gitsigns.nvim',
        lazy = false,
        branch = 'main',
        config = function()
            require('gitsigns').setup {
                on_attach                    = function(bufnr)
                    local gs = package.loaded.gitsigns
                    vim.keymap.set('n', ']g', function()
                        if vim.wo.diff then return ']g' end
                        vim.schedule(function() gs.next_hunk() end)
                        return '<Ignore>'
                    end, { buffer = bufnr, expr = true })

                    vim.keymap.set('n', '[g', function()
                        if vim.wo.diff then return '[g' end
                        vim.schedule(function() gs.prev_hunk() end)
                        return '<Ignore>'
                    end, { buffer = bufnr, expr = true })
                    -- vim.api.nvim_create_autocmd({ 'CursorHold' }, { command = 'Gitsigns preview_hunk' })
                end,
                signs                        = {
                    add          = { hl = 'GitSignsAdd', text = '┃', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
                    change       = { hl = 'GitSignsChange', text = '┃', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
                    delete       = { hl = 'GitSignsDelete', text = '_', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
                    topdelete    = { hl = 'GitSignsDelete', text = '‾', numhl = 'GitSignsDeleteNr', linehl = 'GitSignsDeleteLn' },
                    changedelete = { hl = 'GitSignsChange', text = '~', numhl = 'GitSignsChangeNr', linehl = 'GitSignsChangeLn' },
                    untracked    = { hl = 'GitSignsAdd', text = '┆', numhl = 'GitSignsAddNr', linehl = 'GitSignsAddLn' },
                },
                signcolumn                   = true,  -- Toggle with `:Gitsigns toggle_signs`
                numhl                        = false, -- Toggle with `:Gitsigns toggle_numhl`
                linehl                       = true,  -- Toggle with `:Gitsigns toggle_linehl`
                word_diff                    = false, -- Toggle with `:Gitsigns toggle_word_diff`
                watch_gitdir                 = {
                    interval = 1000,
                    follow_files = true
                },
                attach_to_untracked          = true,
                current_line_blame           = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
                current_line_blame_opts      = {
                    virt_text = true,
                    virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
                    delay = 100,
                    ignore_whitespace = false,
                },
                current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
                sign_priority                = 6,
                update_debounce              = 100,
                status_formatter             = nil,   -- Use default
                max_file_length              = 40000, -- Disable if file is longer than this (in lines)
                preview_config               = {
                    -- Options passed to nvim_open_win
                    border = 'rounded',
                    style = 'minimal',
                    relative = 'cursor',
                    focusable = false,
                    noautocmd = true,
                    row = 0,
                    col = 1
                },
                yadm                         = {
                    enable = false
                },
            }
        end
    },
    {
        'tpope/vim-fugitive',
        branch = 'master',
        keys = {
            { 'g[',        ':diffget //2<CR>' },
            { 'g[',        ':diffget //2<CR>', { mode = 'v' } },
            { 'g]',        ':diffget //3<CR>' },
            { 'g]',        ':diffget //3<CR>', { mode = 'v' } },
            { '<Leader>B', ':Git blame<CR>',   { silent = true } },
        },
    },
    { 'sindrets/diffview.nvim', branch = 'main',   cmd = 'DiffviewOpen' },

    -- Statusbar
    {
        'nvim-lualine/lualine.nvim',
        lazy = false,
        branch = 'master',
        dependencies = {
            { 'kyazdani42/nvim-web-devicons', branch = 'master' },
        },
        config = function()
            require './statusbar'
        end
    },

    -- Comment
    { 'tomtom/tcomment_vim',    branch = 'master', lazy = false },

    -- { 'terryma/vim-multiple-cursors', branch = 'master', lazy = false },
    { 'tpope/vim-unimpaired',   branch = 'master', lazy = false },
    {
        'godlygeek/tabular',
        branch = 'master',
        cmd = 'Tabular',
        keys = {
            { '<Leader>=', ':Tab /=<CR> :%retab!<CR>' },
            { '<Leader>:', ':Tab /:<CR> :%retab!<CR>' },
            { '<Leader>,', ':Tab /,<CR> :%retab!<CR>' },
        }
    },
    {
        'norcalli/nvim-colorizer.lua',
        branch = 'master',
        lazy = false,
        config = function()
            require 'colorizer'.setup()
        end
    },

    -- Welcome
    {
        'mhinz/vim-startify',
        lazy = false,
        branch = 'master',
        config = function()
            vim.g.startify_session_dir = '~/.config/nvim/sessions'
        end
    }
}, {
    defaults = {
        lazy = true
    },
    checker = {
        enabled = true,
        notify = false
    }
});

-- RTL
vim.opt.termbidi = true
vim.opt.mouse = a
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.encoding = 'utf-8'
vim.opt.shiftwidth = 4
vim.opt.showmatch = true
vim.opt.showmode = true
vim.opt.showcmd = true
vim.opt.hidden = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.softtabstop = 4
vim.opt.tabstop = 4
vim.opt.laststatus = 3
vim.opt.expandtab = true
vim.opt.preserveindent = true
vim.opt.scrolloff = 7
vim.opt.ruler = true
-- vim.opt.wh = 10
-- vim.opt.wmh = 10
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Show indentation
vim.opt.list = true
vim.o.listchars = 'multispace:┊   '

-- Maintain undo history between sessions
vim.opt.undolevels = 500
vim.opt.undofile = true
vim.o.undodir = vim.fn.expand(vim.fn.stdpath("data") .. '/undodir')

vim.opt.updatetime = 400
vim.opt.backspace = { 'indent', 'eol', 'start' }
vim.o.timeout = 'timeoutlen: 1000, ttimeoutlen: 100'
vim.opt.linebreak = true
vim.opt.cindent = false
vim.opt.foldmethod = 'indent'
vim.opt.foldlevel = 2
vim.opt.wrap = true
vim.opt.breakindent = true
vim.opt.signcolumn = 'yes'

-- Case insensitive UNLESS using uppercase characters
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Add indent for p/li in html
vim.g.html_indent_tags = 'li│p'

vim.api.nvim_create_user_command('Config', ":exe 'edit ' . stdpath('config') . '/init.lua'", { bang = true, nargs = 0 })
vim.api.nvim_create_user_command('Reload', ":exe 'source ' . stdpath('config') . '/init.lua'", { bang = true, nargs = 0 })

-- Wordpress
vim.api.nvim_create_user_command('Sass', ":silent exe '!sass ' . expand('%:p') . ' ' . expand('%:p:r') . '.css'", {})

-- Clear and Redraw screen when an error happens
vim.keymap.set('n', '<Leader>l', ':redraw!<cr>')

-- ReRender syntax highlights
vim.keymap.set('n', '<F12>', ':syntax sync fromstart<CR>')
vim.keymap.set('i', '<F12>', '<ESC>:syntax sync fromstart<CR>a')

-- clear search
vim.keymap.set('n', '<leader>\\', ':let @/=""<CR>:nohlsearch<CR>', { silent = true })

-- Remap paste
vim.keymap.set('v', 'p', 'P')
vim.keymap.set('v', 'P', 'p')

-- Copy/Paste outside vim
vim.keymap.set('n', '<Leader>y', '"+yiw')
vim.keymap.set('v', '<Leader>y', '"+y')
vim.keymap.set('n', '<Leader>p', '"+p')
vim.keymap.set('v', '<Leader>p', '<Esc>o<Esc>"+p')

-- Copy full address
vim.keymap.set('n', '<Leader>x', ':let @+=expand("%")<CR>')

-- Toggle between 2 last files
vim.keymap.set('n', '<Leader><Leader>', '<C-^>')

-- Max height when opening files
-- vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead', 'BufEnter' }, { pattern = '*', command = 'resize' })

-- Working with split
-- vim.keymap.set('n', '<C-j>', '<C-W>j<C-W>_zz')
-- vim.keymap.set('n', '<C-k>', '<C-W>k<C-W>_zz')
-- vim.keymap.set('n', '<C-l>', '<C-W>l<C-W>_zz')
-- vim.keymap.set('n', '<C-h>', '<C-W>h<C-W>_zz')
vim.keymap.set('n', '<C-j>', '<C-W>j')
vim.keymap.set('n', '<C-k>', '<C-W>k')
vim.keymap.set('n', '<C-l>', '<C-W>l')
vim.keymap.set('n', '<C-h>', '<C-W>h')
vim.keymap.set('n', '<C-<>', '<C-W>> " Increase split size')
vim.keymap.set('n', '<C->>', '<C-W>< " Decrease split size')

-- remap movement to move by column layout
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Aliases for different file types
vim.api.nvim_create_user_command('JSX', ':set ft = javascript.jsx', {})
vim.api.nvim_create_user_command('JS', ':set ft = javascript', {})
vim.api.nvim_create_user_command('HTML', ':set ft = html', {})
vim.api.nvim_create_user_command('PHP', ':set ft = php', {})
vim.api.nvim_create_user_command('SQL', ':set ft = sql', {})

-- Title as filename
vim.api.nvim_create_autocmd('BufEnter',
    { pattern = '*', command = 'let &titlestring = expand("%:t") . " (" . expand("%:~:h") . ") - Vim"' })
vim.opt.title = true

-- Search in VisualMode
vim.keymap.set('v', '/', 'y/<C-R>"<CR>')
vim.keymap.set('v', '/', 'y/<C-R>"<CR>')

-- Replace word under cursor
vim.keymap.set('n', 'cu', ':%s/<C-R><C-W>//cg<Left><Left><Left>')

-- Go to last buffer and delete the current one
vim.keymap.set('n', '<Leader>c', ':bnext<CR>:bd#<CR>', { silent = true })

-- Fold/Unfold saving
local auAutoSaveFolds = vim.api.nvim_create_augroup('AutoSaveFolds', { clear = true });
vim.api.nvim_create_autocmd({ 'BufWinLeave' }, {
    group = auAutoSaveFolds,
    pattern = '*.*',
    command = 'mkview 1',
})
vim.api.nvim_create_autocmd({ 'BufWinEnter' }, {
    group = auAutoSaveFolds,
    pattern = '*.*',
    command = 'silent! loadview 1',
})

vim.keymap.set('n', '<C-u>', '<C-u>zz')
vim.keymap.set('n', '<C-d>', '<C-d>zz')
vim.keymap.set('n', '<C-f>', '<C-f>zz')
vim.keymap.set('n', '<C-b>', '<C-b>zz')

-- JSX Syntax to JS
vim.go.syntastic_javascript_checkers = 'eslint'
vim.go.syntastic_javascript_jsxhint_exec = 'jsx-jshint-wrapper'

-- Lazygit
vim.keymap.set('n', '<Leader>g', ':silent exec "!zellij action new-pane --name Lazygit -c -f -- lazygit"<CR>',
    { silent = true })

-- Prettier on save
-- vim.api.nvim_create_user_command('Prettier', ":call CocAction('runCommand', 'prettier.formatFile')", { bang = true, nargs = 0 })
-- vim.api.nvim_create_autocmd({ 'BufWritePre' }, {
--     group = auQuickfix,
--     pattern = '*.php',
--     command = 'execute "Prettier"',
-- })

local auQuickfix = vim.api.nvim_create_augroup('quickfix', { clear = true });
vim.api.nvim_create_autocmd({ 'QuickFixCmdPost' }, {
    group = auQuickfix,
    pattern = '[^l]*',
    command = 'cwindow',
})
vim.api.nvim_create_autocmd({ 'QuickFixCmdPost' }, {
    group = auQuickfix,
    pattern = 'l*',
    command = 'lwindow',
})
