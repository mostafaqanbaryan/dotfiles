---@alias node unknown
local parsers = require("nvim-treesitter.parsers")

local M = {}

---Wrapper to get treesitter root parser
---@return node|nil
local function get_root()
    local parser = parsers.get_parser()
    if parser == nil then
        return nil
    end

    return parser:parse()[1]:root()
end

---Return node of "parent" that has given "named" as name in nested node
---@param parent node
---@param named string
---@return node|nil
local function get_named_node(parent, named)
    for node, name in parent:iter_children() do
        if name == named then
            return node
        end

        -- some languages have deeply nested structures
        -- in "declarator" parts can exist as well
        if name == "declarator" then
            local named_node = get_named_node(node, named)
            if named_node ~= nil then
                return named_node
            end

            -- when we are the furthest in the recursion and have an identifier, this can also be a function
            if node:type() == "identifier" then
                return node
            end

            return nil
        end
    end
end

---Return node of "parent" that has given "typed" as type in nested node
---@param parent node
---@param typed string
---@return node|nil
local function get_typed_node(parent, typed)
    for node, name in parent:iter_children() do
        if node:type() == typed then
            return node
        end

        -- some languages have deeply nested structures
        -- in "declarator" parts can exist as well
        if name == "declarator" then
            local typed_node = get_typed_node(node, typed)
            if typed_node ~= nil then
                return typed_node
            end

            return nil
        end
    end
end

---Get node information and construct a useable table out of it
---@param node node
---@return NodeInformation|nil
local function get_node_information(node)
    -- can be that some nodes have a not yet supported structure
    -- instead of crashing just ignore the node
    local function_name_node = get_named_node(node, "name")

    -- for example cpp has som edge cases where a "name" named node won't be found
    if function_name_node == nil then
        -- Operator overloads
        function_name_node = get_typed_node(node, "operator_name")
    end

    if function_name_node == nil then
        -- Reference return types
        local fd_node = get_typed_node(node, "function_declarator")
        function_name_node = get_named_node(fd_node, "identifier")
    end

    if function_name_node == nil then
        return nil
    end

    local function_name = vim.treesitter.get_node_text(function_name_node, 0)
    -- as fallback in case named node does not exist
    local line_content = vim.treesitter.get_node_text(node, 0)

    -- return line content in case we have no name (happens if there is no named node)
    function_name = function_name or line_content

    -- zero indexed
    local row, _, _ = node:start()
    local line_number = row + 1

    ---@class NodeInformation
    ---@field line_number number
    ---@field function_name string
    return { line_number = line_number, function_name = function_name }
end

---Some languages (e.g. cpp) might want more information about the scope of a function
---request them of a node and use this to append the node information
---@param node any
---@return string|nil
local function get_scope_information_of_node(node)
    local class_scope_node = get_named_node(node, "scope")
    if class_scope_node ~= nil then
        local is_class_name = class_scope_node:type() == "namespace_identifier"
            or class_scope_node:type() == "template_type"

        if is_class_name then
            return vim.treesitter.get_node_text(class_scope_node, 0) .. "::"
        end
    end

    return nil
end

---Get all functions of the given "parent" node concatted into a table
---@param parent node
---@return NodeInformation[]
local function get_function_list_of_parent(parent)
    ---@type NodeInformation[]
    local content = {}

    if parent == nil then
        return content
    end

    for tsnode in parent:iter_children() do
        -- standard ways of declaring/defining functions
        local is_simple_function = tsnode:type() == "function_declaration"
            or tsnode:type() == "function_definition"
            or tsnode:type() == "local_function"
            or tsnode:type() == "method_definition"
            or tsnode:type() == "method_declaration"
            or tsnode:type() == "constructor_declaration"
            or tsnode:type() == "function_item"

        if is_simple_function then
            local info = get_node_information(tsnode)

            -- enhance function name with scope information
            local node_scope = get_scope_information_of_node(tsnode)
            if node_scope ~= nil and info ~= nil then
                info.function_name = node_scope .. info.function_name
            end
            table.insert(content, info)
        end

        -- some functions might have the information in their parent (assigned variables)
        local is_parent_dependend_function = tsnode:type() == "function_definition" or tsnode:type() == "arrow_function"

        if is_parent_dependend_function then
            -- we want to name of the variable that it was assigned to -> parent
            -- if it has valuable information
            local parent_has_information = tsnode:parent():type() == "variable_declarator"
                or tsnode:parent():type() == "variable_declaration"

            if parent_has_information then
                local info = get_node_information(tsnode:parent())
                table.insert(content, info)
            end
        end

        -- these structures might include functions (arrow function, variable as function, classes, etc)
        local is_simple_recursive_structure = tsnode:type() == "export_statement"
            or tsnode:type() == "variable_declarator"
            or tsnode:type() == "variable_declaration"
            or tsnode:type() == "lexical_declaration"
            or tsnode:type() == "template_declaration"
            or tsnode:type() == "preproc_ifdef"
            or tsnode:type() == "preproc_if"
            or tsnode:type() == "preproc_else"

        if is_simple_recursive_structure then
            local info = get_function_list_of_parent(tsnode)

            for _, node_information in ipairs(info) do
                table.insert(content, node_information)
            end
        end

        -- structure that most likely have multiple functions internally
        local is_complex_recursive_structure = tsnode:type() == "class_declaration"
            or tsnode:type() == "namespace_declaration"
            or tsnode:type() == "namespace_definition"
            or tsnode:type() == "impl_item"
            or tsnode:type() == "mod_item"

        if is_complex_recursive_structure then
            local structure_name_node = get_named_node(tsnode, "name")
            if structure_name_node == nil then
                structure_name_node = get_typed_node(tsnode, "type_identifier")
            end

            local structure_name = nil
            if structure_name_node ~= nil then
                structure_name = vim.treesitter.get_node_text(structure_name_node, 0)
            end

            -- body this might contain functions (methods)
            local body = get_named_node(tsnode, "body")
            local info = get_function_list_of_parent(body)

            local separator = ":"
            if tsnode:type() == "namespace_definition" or tsnode:type() == "impl_item" then
                separator = "::"
            end

            for _, node_information in ipairs(info) do
                -- append structure name infront of methods (or other structures)
                if structure_name ~= nil then
                    node_information.function_name = '[0m' .. structure_name ..
                        separator .. '[0m' .. '[35m' .. node_information.function_name .. '[0;35m'
                end

                table.insert(content, node_information)
            end
        end
    end

    return content
end

---Global endpoint to get all functions of the current buffer
---structured into a table of multiple table informations
---@return NodeInformation[]
M.get_current_functions = function()
    local root = get_root()
    if root == nil then
        print("No Tressitter-parser found in the current buffer")
        return {}
    end

    local ok, content = pcall(get_function_list_of_parent, root)
    if not ok then
        print("Something went wrong in the current buffer")
        print("Current buffer might have unsuported language or syntax")
        return {}
    end

    -- sort content, it could have different order in some edge cases
    table.sort(content, function(a, b)
        return a.line_number < b.line_number
    end)

    return content
end

---Global endpoint to get all functions of the current buffer
---structured into a table of formatted strings for easy usage of a selector
---@alias FormattedInformation string[]
---@return FormattedInformation # example {"line_number:\t function", "123:\t foo", ...}
M.get_current_functions_formatted = function()
    ---@type FormattedInformation
    local res = {}
    local output = M.get_current_functions()

    -- every entry will be concatted into a string
    -- result: {"line_number:\t function", "123:\t foo", ...}
    for _, node_information in ipairs(output) do
        local concatted_string = node_information.function_name ..
            '[0m' .. ":" .. node_information.line_number .. '[0m'
        table.insert(res, concatted_string)
    end

    return res
end

get_block = function()
    local pattern = '%:p:h'
    local current = vim.fn.expand(pattern)
    local dir = current
    while dir ~= '/' do
        local f = io.open(dir .. '/controller.php', 'r')
        if f ~= nil then
            io.close(f)
            return dir
        else
            pattern = pattern .. ':h'
            dir = vim.fn.expand(pattern)
        end
    end
    return current
end

getRoot = function()
    local root = vim.fs.root(0, { '.git', 'Makefile', 'package.json', 'composer.json' })
    if not root then
        root = '.'
    end
    return root
end


return {
    'ibhagwan/fzf-lua',
    branch = 'main',
    cmd = { 'CGFiles', 'CBuffers', 'CurrentDirFiles' },
    keys = {
        { '<Leader>fm' },
        { '<Leader>fa', '<cmd>lua require("fzf-lua").files()<CR>',                                                                                                         { silent = true } },
        { '<Leader>fb', '<cmd>lua require("fzf-lua").buffers()<CR>',                                                                                                       { silent = true } },
        { '<Leader>fc', '<cmd>lua require("fzf-lua").files({ cwd = get_block() })<CR>',                                                                                    { silent = true } },
        { '<Leader>fg', '<cmd>ListFilesFromBranch<CR>',                                                                                                                    { silent = true } },
        { '<Leader>fs', '<cmd>lua require("fzf-lua").lsp_document_symbols({ winopts = { preview = { layout = "horizontal" }}})<CR>',                                       { silent = true } },
        { '<Leader>iw', '<cmd>lua require("fzf-lua").grep_cword({ cwd = getRoot()  })<CR>',                                                                                { silent = true } },
        { '<Leader>iW', '<cmd>lua require("fzf-lua").grep_cWORD({ cwd = getRoot() })<CR>',                                                                                 { silent = true } },
        { '<Leader>?',  '<cmd>lua require("fzf-lua").blines()<CR>',                                                                                                        { silent = true } },
        { '<Leader>/',  '<cmd>lua require("fzf-lua").grep({ cwd = getRoot() })<CR>',                                                                                       { silent = true } },
        { '<Leader>/',  '<cmd>lua require("fzf-lua").grep_visual({ cwd = getRoot() })<CR>',                                                                                { silent = true }, mode = 'v', },
        { 'gr',         '<cmd>lua require("fzf-lua").lsp_references({ sync = true, jump_to_single_result = true, winopts = { preview = { layout = "horizontal" }}})<CR>',  { silent = true } },
        { 'gd',         '<cmd>lua require("fzf-lua").lsp_definitions({ sync = true, jump_to_single_result = true, winopts = { preview = { layout = "horizontal" }}})<CR>', { silent = true } },
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
                    vim.keymap.set("t", "<C-u>", "<S-up>", { silent = true, buffer = true, remap = true })
                    vim.keymap.set("t", "<C-d>", "<S-down>", { silent = true, buffer = true, remap = true })
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
            finder = {
                async = false
            }
        })

        vim.keymap.set('n', '<leader>fm', function()
            local function get_line(selected)
                -- local doSplit = string.gmatch(selected[1], "([0-9]+):\t")
                local doSplit = string.gmatch(selected[1], ":([0-9]+)")
                local line_num = doSplit()
                return tonumber(line_num)
            end

            local fzf = require 'fzf-lua'
            local filename = vim.fn.expand('%')
            local lines = vim.api.nvim_buf_line_count(0)
            fzf.fzf_exec(M.get_current_functions_formatted(), {
                ansi = true,
                prompt = 'Functions > ',
                preview = require 'fzf-lua'.shell.raw_preview_action_cmd(function(selected)
                    local line = get_line(selected)
                    local start_pos = math.max(line - 5, 1)
                    local end_pos = math.min(line + 5, lines)
                    return string.format("bat --style=default --color=always -H %d --line-range %d:%d %s", line,
                        start_pos,
                        end_pos,
                        filename)
                end),
                actions = {
                    ['default'] = function(selected)
                        vim.api.nvim_win_set_cursor(0, { get_line(selected), 0 })
                    end
                }
            })
        end)

        vim.api.nvim_create_user_command('ListFilesFromBranch', function()
            require 'fzf-lua'.files({
                cmd = "git status --porcelain | awk '{ print $2 }'",
                prompt = "HEAD > ",
                previewer = false,
                preview = require 'fzf-lua'.shell.raw_preview_action_cmd(function(items)
                    local file = require 'fzf-lua'.path.entry_to_file(items[1])
                    return string.format('git diff HEAD -- "%s" | delta --line-numbers', file.path)
                end)
            })
        end, {
            nargs = 0,
        })
    end
}
