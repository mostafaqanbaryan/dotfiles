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
    { import = "plugins.lsp" },
    { import = "plugins.git" },
    { import = "plugins" },
}, {
    defaults = {
        lazy = true
    },
    checker = {
        enabled = true,
        notify = false
    }
});
