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
		{ '<Leader>2' },
		{ '<Leader>f',  '<cmd>lua require("fzf-lua").git_files()<CR>',                                                                                                     { silent = true } },
		{ '<Leader>b',  '<cmd>lua require("fzf-lua").buffers()<CR>',                                                                                                       { silent = true } },
		{ '<Leader>o',  '<cmd>lua require("fzf-lua").files({ cwd = get_block() })<CR>',                                                                                    { silent = true } },
		{ '<Leader>g',  '<cmd>ListFilesFromBranch<CR>',                                                                                                                    { silent = true } },
		{ '<Leader>iw', '<cmd>lua require("fzf-lua").grep_cword({ cwd = getRoot()  })<CR>',                                                                                { silent = true } },
		{ '<Leader>iW', '<cmd>lua require("fzf-lua").grep_cWORD({ cwd = getRoot() })<CR>',                                                                                 { silent = true } },
		{ '<Leader>/',  '<cmd>lua require("fzf-lua").grep({ cwd = getRoot() })<CR>',                                                                                       { silent = true } },
		{ '<Leader>/',  '<cmd>lua require("fzf-lua").grep_visual({ cwd = getRoot() })<CR>',                                                                                { silent = true }, mode = 'v', },
		{ '<Leader>s',  '<cmd>lua require("fzf-lua").lsp_document_symbols({ winopts = { preview = { layout = "horizontal" }}})<CR>',                                       { silent = true } },
		{ 'gr',         '<cmd>lua require("fzf-lua").lsp_references({ sync = true, jump_to_single_result = true, winopts = { preview = { layout = "horizontal" }}})<CR>',  { silent = true } },
		{ 'gd',         '<cmd>lua require("fzf-lua").lsp_definitions({ sync = true, jump_to_single_result = true, winopts = { preview = { layout = "horizontal" }}})<CR>', { silent = true } },
		{ '<F4>',       '<cmd>lua require("fzf-lua").lsp_code_actions({ winopts = { preview = { layout = "horizontal" }}})<CR>',                                           { silent = true } },
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
			git = {
				files = {
					cmd = 'git ls-files --exclude-standard --cached --others'
				}
			},
			finder = {
				async = false
			}
		})

		vim.keymap.set('n', '<leader>2', function()
			local function fetch()
				local query = vim.treesitter.query.parse('php',
					'(method_declaration (name)  @name) (function_definition (name)  @name)')
				local line_count = vim.api.nvim_buf_line_count(0)
				local parser = vim.treesitter.get_parser(0, 'php')

				local syntax = parser:parse()
				local tree = syntax[1]:root()

				local list = {}

				for _, node, _ in query:iter_captures(tree, 0, 0, line_count) do
					table.insert(list, node:start() .. "\t" .. vim.treesitter.get_node_text(node, 0))
				end

				return list
			end

			local function get_line(selected)
				local doSplit = string.gmatch(selected[1], "([0-9]+)\t")
				local line_num = doSplit()
				return tonumber(line_num) + 1
			end

			local fzf = require 'fzf-lua'
			local filename = vim.fn.expand('%')
			local lines = vim.api.nvim_buf_line_count(0)
			fzf.fzf_exec(fetch(), {
				prompt = 'functions > ',
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
