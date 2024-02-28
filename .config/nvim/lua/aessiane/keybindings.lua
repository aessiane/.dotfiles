-- Completion
vim.cmd([[
 inoremap <silent><script><expr> <C-space> coc#pum#visible() ? coc#pum#cancel() : copilot#Accept("\<C-space>")

 imap <expr> <C-j> coc#pum#visible() ? "\<C-n>" : "\<Tab>"
 imap <expr> <C-k> coc#pum#visible() ? "\<C-p>" : "\<S-Tab>"
]])

vim.keymap.set('n', 'gd', '<Plug>(coc-definition)', { silent = true })
vim.keymap.set('n', 'gy', '<Plug>(coc-type-definition)', { silent = true })
vim.keymap.set('n', 'gi', '<Plug>(coc-implementation)', { silent = true })
vim.keymap.set('n', 'gr', '<Plug>(coc-references)', { silent = true })

-- Swap colon and semicolon
vim.keymap.set({ 'n', 'v' }, ';', ':')
vim.keymap.set({ 'n', 'v' }, ':', ';')

-- Change leader key from " to '
vim.g.mapleader = "'"
vim.g.maplocalleader = ","

-- Buffer navigation
vim.keymap.set('n', '<leader>n', vim.cmd.bnext)
vim.keymap.set('n', '<leader>p', vim.cmd.bprevious)
vim.keymap.set('n', '<leader>d', vim.cmd.bdelete)

-- Telescope
-- TODO: If git repo, use git_files else find_files
vim.keymap.set('n', '<leader>ff', '<cmd>Telescope git_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
