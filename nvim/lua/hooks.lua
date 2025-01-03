vim.api.nvim_create_autocmd({ "BufRead", "BufEnter" }, {
    callback = function(ctx)
        if vim.bo.filetype ~= "rnvimr" then
            local root = vim.fs.root(ctx.buf, { '.git' })
            if root then
                vim.fn.chdir(root)
            else
                vim.fn.chdir(vim.fn.expand('%:p:h'))
            end
        end
    end
})
