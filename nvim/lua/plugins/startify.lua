return {
	'mhinz/vim-startify',
	lazy = false,
	branch = 'master',
	config = function()
		-- Start from 1
		vim.g.startify_custom_indices = vim.cmd("map(range(1,100), 'string(v:val)')")
		vim.g.startify_session_sort = 1
		vim.g.startify_session_number = 10
		vim.g.startify_session_persistence = 1
		vim.g.startify_session_dir = '~/.config/nvim/sessions'

		vim.g.startify_commands = {
			{ c = { 'Open Configs', ':Config' } }
		}
		vim.g.startify_lists = {
			{ type = 'commands',  header = { '   [Commands]' } },
			{ type = 'files',     header = { '   [Files]' } },
			{ type = 'dir',       header = { '   [Directory] ' .. vim.fn.getcwd() } },
			{ type = 'sessions',  header = { '   [Sessions]' } },
			{ type = 'bookmarks', header = { '   [Bookmarks]' } },
		}
		vim.g.startify_custom_header = {
			"                                                                                                    ",
			"                                                                                                    ",
			"                                                                                                    ",
			"                         .^!^                                           .!~:                        ",
			"                    ^!JPB&B7.                                            !&&BPJ!:                   ",
			"                ^?P#@@@@@G.                   :       :                   ~@@@@@&B5!:               ",
			"             ^JB@@@@@@@@@7                   .#~     ?G                   .&@@@@@@@@&G?:            ",
			"          .7G@@@@@@@@@@@@#!                  7@&^   ~@@^                 .5@@@@@@@@@@@@@G7.         ",
			"        .?#@@@@@@@@@@@@@@@@BY!^.             B@@&BBB&@@Y              :~Y#@@@@@@@@@@@@@@@@#?.       ",
			"       !#@@@@@@@@@@@@@@@@@@@@@@#G5Y?!~^:..  ~@@@@@@@@@@#.   ..::^!7J5B&@@@@@@@@@@@@@@@@@@@@@#!      ",
			"     .5@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&##B#@@@@@@@@@@@BBBB##&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y     ",
			"    :B@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@5    ",
			"   .B@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@J   ",
			"   5@&#BGGPPPPPGGB&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&BGGP555PPGBB#&#:  ",
			"   ^:.            .^!YB@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&57^.            .:^.  ",
			"                       ~G@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@5:                      ",
			"                         P@@@#BGGGGB#@@@@@@@@@@@@@@@@@@@@@@@@@#BP5555PG#@@@P                        ",
			"                         :J!:.      .^!JG&@@@@@@@@@@@@@@@@#57^.        .:!5~                        ",
			"                                         :?G@@@@@@@@@@@@P!.                                         ",
			"                                            ~5@@@@@@@@5^                                            ",
			"                                              ^P@@@@G^                                              ",
			"                                                !#@?                                                ",
			"                                                 :^                                                 ",
			"                                                                                                    ",
			"                                                                                                    ",
			"                                                                                                    ",
		}
	end
}
