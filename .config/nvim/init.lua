require('aessiane/plugins')
require('aessiane/keybindings')

-- GENERAL CONFIUGRATION

-- Configure colorscheme
vim.cmd('colorscheme tokyonight-moon')

-- My sane defaults
vim.opt.autochdir = true
vim.opt.relativenumber = true

-- Share the system clipboard with vim
vim.opt.clipboard = 'unnamedplus'

-- (coc.nvim) Longer updatetime (default is 4000 ms = 4s) leads to noticeable delays and poor user experience
vim.opt.updatetime = 300
-- (coc.nvim) Always show the signcolumn, otherwise it would shift the text each time " diagnostics appear/become resolved
vim.opt.signcolumn = 'yes'

-- Configure tabs
vim.opt.shiftwidth = 4
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.tabstop = 8
vim.opt.softtabstop = 0
