return {
    'norcalli/nvim-colorizer.lua',
    branch = 'master',
    lazy = false,
    config = function()
        require 'colorizer'.setup()
    end
}
