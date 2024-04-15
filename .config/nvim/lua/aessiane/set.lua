-- GENERAL CONFIUGRATION

-- Configure colorscheme
vim.cmd('colorscheme tokyonight-night') -- Changed in 04/2024 from tokyonight-moon

-- My sane defaults
vim.opt.nu = true
vim.opt.relativenumber = true

vim.opt.autochdir = true

vim.opt.wrap = false

-- Share the system clipboard with vim
vim.opt.clipboard = 'unnamedplus'

-- (coc.nvim) Longer updatetime (default is 4000 ms = 4s)
--     leads to noticeable delays and poor user experience
vim.opt.updatetime = 250
-- (coc.nvim) Always show the signcolumn, otherwise it
--     would shift the text each time " diagnostics
--     appear/become resolved
vim.opt.signcolumn = 'yes'

-- Configure tabs
vim.opt.smarttab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Configure search
vim.opt.hlsearch = true
vim.opt.incsearch = true

vim.opt.termguicolors = true

vim.opt.scrolloff = 6
