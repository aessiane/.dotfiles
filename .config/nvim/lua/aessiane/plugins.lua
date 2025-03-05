--
-- 1. PLUGINS INSTALLATION
--

local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.local/share/nvim/plugged')

-- AI
Plug('madox2/vim-ai')

-- Execute code from files & pane sharing
Plug('Olical/conjure')
Plug('jpalardy/vim-slime')

--  Completion
Plug('neoclide/coc.nvim', { branch = 'release' })
Plug('github/copilot.vim', { branch = 'release' })

--  Telescope & it's dependencies
Plug('nvim-telescope/telescope.nvim')
Plug('nvim-treesitter/nvim-treesitter', { ['do'] = ':TSUpdate' })
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })

-- Avante and dependencies
Plug('stevearc/dressing.nvim')
Plug('MunifTanjim/nui.nvim')
Plug('MeanderingProgrammer/render-markdown.nvim')

Plug('echasnovski/mini.icons')
Plug('HakonHarnes/img-clip.nvim')

Plug('yetone/avante.nvim', { branch = 'main', ['do'] = 'make' })


-- TODO: configure plugin
Plug('easymotion/vim-easymotion')
Plug('scrooloose/nerdcommenter')

-- CamelMotion
Plug('bkad/CamelCaseMotion')

--  Tmux
Plug('christoomey/vim-tmux-navigator')

--  Python
Plug('nvie/vim-flake8')
Plug('psf/black')
Plug('tell-k/vim-autopep8')

--  Vim general stuff
Plug('jez/vim-superman')
Plug('tpope/vim-sensible')
Plug('bling/vim-airline')
Plug('tpope/vim-repeat')
Plug('tpope/vim-unimpaired')

--  Languages support
Plug('dag/vim-fish')

--  Moving around
Plug('tpope/vim-surround')
Plug('junegunn/fzf')
Plug('wellle/targets.vim')
Plug('scrooloose/nerdtree', { on = 'NERDTreeToggle' })

--  Version control
Plug('airblade/vim-gitgutter')
Plug('tpope/vim-fugitive')
Plug('rhysd/committia.vim')

--  General code utility
Plug('bronson/vim-trailing-whitespace')
Plug('raimondi/delimitMate')
Plug('rking/ag.vim')

--  Colorschmes
Plug('crusoexia/vim-monokai')
Plug('morhetz/gruvbox')
Plug('folke/tokyonight.nvim')

--  Javascript & Typescript
Plug('pangloss/vim-javascript')
Plug('mxw/vim-jsx')
Plug('elzr/vim-json')
Plug('leafgarland/typescript-vim')

--  Windows swapping
Plug('wesQ3/vim-windowswap')

-- TODOs
Plug('folke/todo-comments.nvim')

-- Undo tree
Plug('mbbill/undotree')

-- Translation
Plug('voldikss/vim-translator')

-- Helm
Plug('towolf/vim-helm')

vim.call('plug#end')

--
-- 2. PLUGINS CONFIGURATION
--

require('aessiane/plugins/airline')
require('aessiane/plugins/committia')
require('aessiane/plugins/conjure')
require('aessiane/plugins/copilot')
require('aessiane/plugins/nvim-treesitter')
require('aessiane/plugins/telescope')
require('aessiane/plugins/vim-slime')
require('aessiane/plugins/undotree')
require('aessiane/plugins/todo-comments')
require('aessiane/plugins/vim-translator')
require('aessiane/plugins/render-markdown')
require('aessiane/plugins/avante')
