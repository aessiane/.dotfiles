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

local use_git_files_if_in_git_repo = function()
    local output = vim.fn.system('git rev-parse --is-inside-work-tree') -- string
    if string.sub(output, 0, 4) == "true" then
        return vim.cmd('Telescope git_files')
    else
        return vim.cmd('Telescope find_files')
    end
end

--vim.keymap.set('n', '<leader>ff', use_git_files_if_in_git_repo)
vim.keymap.set('n', '<leader>ff', use_git_files_if_in_git_repo)
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')
