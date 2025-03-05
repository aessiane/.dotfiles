--  Colorschmes (old ones)
-- Plug('crusoexia/vim-monokai')
-- Plug('morhetz/gruvbox')
return {
    'folke/tokyonight.nvim',
    priority = 1000, -- make sure to load this before all the other plugins
    config = function()
        -- load the colorscheme
        vim.cmd([[colorscheme tokyonight-night]])
    end,
}
