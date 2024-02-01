" Configuration file for Neovim

""
"" General configuration
""
set autochdir
set relativenumber

""
"" Plugins
""
call plug#begin('~/.local/share/nvim/plugged')

" Completion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" Telescope & it's dependencies
Plug 'nvim-telescope/telescope.nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }

"TODO: configure plugin
Plug 'easymotion/vim-easymotion'
Plug 'scrooloose/nerdcommenter'

"CamelMotion
Plug 'bkad/CamelCaseMotion'

" Tmux
Plug 'christoomey/vim-tmux-navigator'

" Python
Plug 'nvie/vim-flake8'
Plug 'psf/black'
Plug 'tell-k/vim-autopep8'

" Vim general stuff
Plug 'jez/vim-superman'
Plug 'tpope/vim-sensible'
Plug 'bling/vim-airline'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-unimpaired'

" Languages support
Plug 'dag/vim-fish'

" Moving around
Plug 'tpope/vim-surround'
Plug 'junegunn/fzf'
Plug 'wellle/targets.vim'
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }

" Version control
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'rhysd/committia.vim'

" General code utility
Plug 'bronson/vim-trailing-whitespace'
Plug 'raimondi/delimitMate'
Plug 'rking/ag.vim' " With cheatsheet

" Colorschmes
Plug 'crusoexia/vim-monokai'
Plug 'morhetz/gruvbox'
Plug 'folke/tokyonight.nvim'

" Javascript & Typescript
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'elzr/vim-json'
Plug 'leafgarland/typescript-vim'

" Windows swapping
Plug 'wesQ3/vim-windowswap'

" Markdown pandoc highlighting
Plug 'vim-pandoc/vim-pandoc'
Plug 'vim-pandoc/vim-pandoc-syntax'

call plug#end()

" Powerline font configuration for Airline
let g:airline_powerline_fonts = 1

" Configure colorscheme
colorscheme tokyonight-moon

" Re-map colon to semi-colon
nnoremap ; :
nnoremap : ;
vnoremap ; :
vnoremap : ;

" Change leader to single quote
let mapleader = "'"

" Map buffer switching
nnoremap <leader>n :bnext<CR>
nnoremap <leader>p :bprevious<CR>
nnoremap <leader>d :bd<CR>

" Share clipboard with system
set clipboard+=unnamedplus

""
"" Configuration for coc.nvim
""

" Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
" delays and poor user experience
set updatetime=300

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes

""
"" Configuration for copilot.nvim & coc.nvim
""
let g:copilot_no_tab_map = v:true
imap <silent><script><expr> <C-e> coc#pum#visible() ? coc#pum#cancel() : copilot#Accept("\<C-e>")

""
"" Configuration for telescope.nvim
""
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" Load telescope-fzf-native.nvim

lua << EOF
require('telescope').load_extension('fzf')
EOF
