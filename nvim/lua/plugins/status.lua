return {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    branch = 'master',
    dependencies = {
        { 'kyazdani42/nvim-web-devicons', branch = 'master' },
    },
    config = function()
        -- Color table for highlights
        -- stylua: ignore
        local colors = {
            bg       = '#1f2335',
            fg       = '#bbc2cf',
            yellow   = '#ECBE7B',
            cyan     = '#008080',
            darkblue = '#081633',
            green    = '#98be65',
            orange   = '#FF8800',
            violet   = '#a9a1e1',
            magenta  = '#c678dd',
            blue     = '#7aa2f7',
            red      = '#ec5f67',
        }

        local conditions = {
            buffer_not_empty = function()
                return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
            end,
            hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end,
            check_git_workspace = function()
                local filepath = vim.fn.expand('%:p:h')
                local gitdir = vim.fn.finddir('.git', filepath .. ';')
                return gitdir and #gitdir > 0 and #gitdir < #filepath
            end,
        }

        -- Config
        local config = {
            extensions = { 'fzf', 'fugitive' },
            options = {
                disabled_filetypes = {
                    statusline = {},
                    winbar = {
                        "help",
                        "startify",
                        "dashboard",
                        "packer",
                        "neogitstatus",
                        "NvimTree",
                        "Trouble",
                        "alpha",
                        "lir",
                        "Outline",
                        "spectre_panel",
                        "toggleterm",
                    },
                },
                -- Disable sections and component separators
                component_separators = '',
                section_separators = '',
                theme = {
                    -- We are going to use lualine_c an lualine_x as left and
                    -- right section. Both are highlighted by c theme .  So we
                    -- are just setting default looks o statusline
                    normal = { c = { fg = colors.fg, bg = colors.bg } },
                    inactive = { c = { fg = colors.fg, bg = colors.bg } },
                },
                winbar = {
                    "help",
                    "startify",
                    "dashboard",
                    "packer",
                    "neogitstatus",
                    "NvimTree",
                    "Trouble",
                    "alpha",
                    "lir",
                    "Outline",
                    "spectre_panel",
                    "toggleterm",
                },
            },
            --[[ winbar = {
            lualine_a = { 'diagnostics' },
            lualine_b = {},
            lualine_c = {},
            lualine_x = { get_winbar },
            lualine_y = {},
            lualine_z = {},
            },
            inactive_winbar = {
            lualine_a = {},
            lualine_b = {},
            lualine_c = {},
            lualine_x = {},
            lualine_y = {},
            lualine_z = {},
            }, ]]
            sections = {
                -- these are to remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                -- These will be filled later
                lualine_c = {},
                lualine_x = {},
            },
            inactive_sections = {
                -- these are to remove the defaults
                lualine_a = {},
                lualine_b = {},
                lualine_y = {},
                lualine_z = {},
                lualine_c = {},
                lualine_x = {},
            },
        }

        -- Inserts a component in lualine_c at left section
        local function ins_left(component)
            table.insert(config.sections.lualine_c, component)
        end

        -- Inserts a component in lualine_x ot right section
        local function ins_right(component)
            table.insert(config.sections.lualine_x, component)
        end

        ins_left {
            function()
                return '▊'
            end,
            color = { fg = colors.blue }, -- Sets highlighting of component
            padding = { left = 0, right = 1 }, -- We don't need space before this
        }

        ins_left {
            -- mode component
            function()
                return ''
            end,
            color = function()
                -- auto change color according to neovims mode
                local mode_color = {
                    n = colors.red,
                    i = colors.green,
                    v = colors.blue,
                    [''] = colors.blue,
                    V = colors.blue,
                    c = colors.magenta,
                    no = colors.red,
                    s = colors.orange,
                    S = colors.orange,
                    [''] = colors.orange,
                    ic = colors.yellow,
                    R = colors.violet,
                    Rv = colors.violet,
                    cv = colors.red,
                    ce = colors.red,
                    r = colors.cyan,
                    rm = colors.cyan,
                    ['r?'] = colors.cyan,
                    ['!'] = colors.red,
                    t = colors.red,
                }
                return { fg = mode_color[vim.fn.mode()] }
            end,
            padding = { right = 1 },
        }

        ins_left {
            require("lazy.status").updates,
            cond = require("lazy.status").has_updates,
            color = { fg = "#ff9e64" }, -- Sets highlighting of component
        }

        ins_left {
            'branch',
            icon = '',
            color = { fg = colors.violet, gui = 'bold' },
        }

        -- local function filepath()
        --     local s = vim.fn.expand('%:~:h:t')
        --     local s2 = vim.fn.expand('%:~:h:h:t')
        --     if s2 ~= '.' then
        --         s = s2 .. '/' .. s
        --     end
        --     local s3 = vim.fn.expand('%:~:h:h:h:t')
        --     if s3 ~= '.' then
        --         s = s3 .. '/' .. s
        --     end
        --     s = s .. '/' .. vim.fn.expand('%:~:t')
        --     return s
        -- end

        -- Insert mid section. You can make any number of sections in neovim :)
        -- for lualine it's any number greater then 2
        ins_left {
            function()
                return '%='
            end,
        }

        ins_left {
            'filename',
            path = 1,
            cond = conditions.buffer_not_empty,
            color = { fg = colors.magenta, gui = 'bold' },
            symbols = {
                modified = "",
                readonly = "󰌾"
            }
        }

        ins_left {
            'diagnostics',
            sources = {'nvim_diagnostic', 'coc'},
            always_visible = false,
            update_in_insert = false,
            symbols = { error = ' ', warn = ' ', info = ' ' },
            diagnostics_color = {
                color_error = { fg = colors.red },
                color_warn = { fg = colors.yellow },
                color_info = { fg = colors.cyan },
            },
        }

        -- Add components to right sections
        ins_right {
            require("noice").api.statusline.mode.get,
            cond = require("noice").api.statusline.mode.has,
            color = { fg = "#ff9e64" },
        }

        ins_right { 'location', color = { fg = colors.orange, gui = 'bold' }  }

        ins_right {
            'o:encoding', -- option component same as &encoding in viml
            fmt = string.upper, -- I'm not sure why it's upper case either ;)
            cond = conditions.hide_in_width,
            color = { fg = colors.green, gui = 'bold' },
        }

        ins_right {
            'filetype',
            fmt = string.upper,
            color = { fg = colors.blue, gui = 'bold' },
        }

        ins_right {
            'diff',
            -- Is it me or the symbol for modified us really weird
            symbols = { added = ' ', modified = '柳 ', removed = ' ' },
            diff_color = {
                added = { fg = colors.green },
                modified = { fg = colors.orange },
                removed = { fg = colors.red },
            },
            cond = conditions.hide_in_width,
        }

        ins_right { 'progress' }

        ins_right {
            function()
                return '▊'
            end,
            color = { fg = colors.blue },
            padding = { left = 1 },
        }

        -- Now don't forget to initialize lualine
        require('lualine').setup(config)
    end
}
