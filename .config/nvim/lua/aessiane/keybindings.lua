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

vim.keymap.set('n', '<leader>ff', use_git_files_if_in_git_repo)
vim.keymap.set('n', '<C-p>', '<cmd>Telescope find_files<cr>')
vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
vim.keymap.set('n', '<leader>fh', '<cmd>Telescope help_tags<cr>')

-- Open Ex mode
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Allow to  move selected text
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep cursor where it was when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursoer in the middle when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- GREAT! Allow paste without overwriting the clipboard
vim.keymap.set("x", "<leader>p", "\"_dP")
