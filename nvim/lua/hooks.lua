vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
	callback = function(ctx)
		local root = vim.fs.root(ctx.buf, { '.git', 'Makefile', 'package.json', 'composer.json' })
		-- local root = vim.fs.root(0, { '.git', 'Makefile', 'package.json', 'composer.json' })
		if root then
			vim.fn.chdir(root)
		else
			vim.fn.chdir(vim.fn.expand('%:p:h'))
		end
	end
})
