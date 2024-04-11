getRoot = function()
	local value = io.popen("git rev-parse --show-toplevel"):read("*a"):gsub("[\n\r]", "")
	if not value then
		value = '.'
	end
	return value
end


return {
	'ibhagwan/fzf-lua',
	branch = 'main',
	cmd = { 'CGFiles', 'CBuffers', 'CurrentDirFiles' },
	keys = {
		{ '<Leader>@' },
		{ '<Leader>f',  '<cmd>lua require("fzf-lua").git_files()<CR>',                                                           { silent = true } },
		{ '<Leader>b',  '<cmd>lua require("fzf-lua").buffers()<CR>',                                                             { silent = true } },
		{ '<Leader>o',  '<cmd>lua require("fzf-lua").files({ cwd = vim.fn.expand("%:p:h")})<CR>',                                { silent = true } },
		{ '<Leader>iw', '<cmd>lua require("fzf-lua").grep_cword({ cwd = getRoot()  })<CR>',                                      { silent = true } },
		{ '<Leader>iW', '<cmd>lua require("fzf-lua").grep_cWORD({ cwd = getRoot() })<CR>',                                       { silent = true } },
		{ '<Leader>/',  '<cmd>lua require("fzf-lua").grep({ cwd = getRoot() })<CR>',                                             { silent = true } },
		{ '<Leader>/',  '<cmd>lua require("fzf-lua").grep_visual({ cwd = getRoot() })<CR>',                                      { silent = true }, mode = 'v', },
		{ '<F4>',       '<cmd>lua require("fzf-lua").lsp_code_actions({ winopts = { preview = { layout = "horizontal" }}})<CR>', { silent = true } },
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
			}
		})

		vim.keymap.set('n', '<leader>@', function()
			function fetch()
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

			function get_line(selected)
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
	end
}
