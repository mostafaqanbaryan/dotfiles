local timer = vim.loop.new_timer()
return {
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
				-- vim.api.nvim_create_autocmd({ 'CursorHold' }, {
				-- 	callback = function()
				-- 		timer:stop()
				-- 		timer:start(1000, 0, vim.schedule_wrap(function()
				-- 			gs.preview_hunk()
				-- 		end))
				-- 	end
				-- })
				-- Actions
				vim.keymap.set('n', '<leader>hs', function() vim.schedule(function() gs.stage_hunk() end) end)
				vim.keymap.set('n', '<leader>hr', function() vim.schedule(function() gs.reset_hunk() end) end)
				vim.keymap.set('n', '<leader>hS', function() vim.schedule(function() gs.stage_buffer() end) end)
				vim.keymap.set('n', '<leader>hu', function() vim.schedule(function() gs.undo_stage_hunk() end) end)
				vim.keymap.set('n', '<leader>hR', function() vim.schedule(function() gs.reset_buffer() end) end)
				vim.keymap.set('n', '<leader>hp', function() vim.schedule(function() gs.preview_hunk() end) end)
				vim.keymap.set('n', '<leader>tb',
					function() vim.schedule(function() gs.toggle_current_line_blame() end) end)
				vim.keymap.set('n', '<leader>hd', function() vim.schedule(function() gs.diffthis() end) end)
				vim.keymap.set('n', '<leader>td', function() vim.schedule(function() gs.toggle_deleted() end) end)
				vim.keymap.set('n', '<leader>hb',
					function() vim.schedule(function() gs.blame_line({ full = true }) end) end)
				vim.keymap.set('v', '<leader>hs',
					function() vim.schedule(function() gs.stage_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end) end)
				vim.keymap.set('v', '<leader>hr',
					function() vim.schedule(function() gs.reset_hunk({ vim.fn.line('.'), vim.fn.line('v') }) end) end)
				vim.keymap.set('n', '<leader>hD', function() vim.schedule(function() gs.diffthis('~') end) end)

				-- Text object
				-- vim.keymap.set({ 'o', 'x' }, 'ih', ':<C-U>Gitsigns select_hunk<CR>')
			end,
			numhl                        = true, -- Toggle with `:Gitsigns toggle_numhl`
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
		}
	end
}
