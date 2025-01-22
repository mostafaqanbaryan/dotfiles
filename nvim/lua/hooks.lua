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


-- Toggle search highlight on moving cursor
vim.api.nvim_create_autocmd("InsertEnter", {
    group = vim.api.nvim_create_augroup("ToggleSearchHighlight", { clear = true }),
    callback = function()
        vim.schedule(function() vim.cmd("nohlsearch") end)
    end
})
vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup("ToggleSearchHighlight", { clear = true }),
    callback = function()
        local view, rpos = vim.fn.winsaveview(), vim.fn.getpos(".")
        vim.cmd(string.format("silent! keepjumps go%s",
            (vim.fn.line2byte(view.lnum) + view.col + 1 - (vim.v.searchforward == 1 and 2 or 0))))
        local ok, _ = pcall(vim.cmd, "silent! keepjumps norm! n")
        local insearch = ok and (function()
            local npos = vim.fn.getpos(".")
            return npos[2] == rpos[2] and npos[3] == rpos[3]
        end)()
        -- restore original view and position
        vim.fn.winrestview(view)
        if not insearch then
            vim.schedule(function() vim.cmd("nohlsearch") end)
        end
    end
})
