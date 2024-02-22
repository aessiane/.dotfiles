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
Plug('nvim-treesitter/nvim-treesitter')
Plug('nvim-lua/plenary.nvim')
Plug('nvim-telescope/telescope-fzf-native.nvim', { ['do'] = 'make' })

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

--  Markdown pandoc highlighting
Plug('vim-pandoc/vim-pandoc')
Plug('vim-pandoc/vim-pandoc-syntax')

vim.call('plug#end')

--
-- 2. PLUGINS CONFIGURATION
--

-- Plugin: copilot.vim
vim.g.copilot_no_tab_map = true

-- Plugin: Airline
-- Configure Powerline fonts for Airline
vim.g.airline_powerline_fonts = 1

-- Plugin: Telescope
-- Load the telescope extensions
require('telescope').load_extension('fzf')

-- Plugin: Conjure
vim.g["conjure#client#python#stdio#command"] = "find_python.sh"

-- Plugin: Treesitter
-- import nvim-treesitter plugin safely
local status, treesitter = pcall(require, "nvim-treesitter.configs")
if not status then
	return
end

-- configure treesitter
treesitter.setup({
	-- enable syntax highlighting
	highlight = {
		enable = true,
	},
	-- enable indentation
	indent = { enable = true },
	-- ensure these language parsers are installed
	ensure_installed = {
		"bash",
		"css",
		"csv",
		"dockerfile",
		"fish",
		"git_config",
		"git_rebase",
		"gitcommit",
		"gitignore",
		"graphql",
		"html",
		"javascript",
		"json",
		"lua",
		"markdown",
		"markdown_inline",
		"python",
		"sql",
		"terraform",
		"toml",
		"typescript",
		"vim",
		"yaml"
	},
	-- auto install above language parsers
	auto_install = true,
})

-- Plugin: vim-slime
-- Set the default target for vim-slime
vim.g.slime_target = "tmux"

-- Configure python
--vim.g.slime_python_ipython = 1
vim.g.slime_bracketed_paste = 1

-- Plugin: committia.vim

local WAITING_MESSAGE = "Generating commit message..."

local splitText = function(text)
	local lines = {}
	for s in text:gmatch("[^\r\n]+") do
		table.insert(lines, s)
	end
	return lines
end

local insert_lines_at_beginning = function(lines)
	-- Check if the first line is our waiting message
	if vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == WAITING_MESSAGE then
		-- Remove the waiting message
		vim.api.nvim_buf_set_lines(0, 0, 1, false, {})
	end

	vim.api.nvim_buf_set_lines(0, 0, 0, false, lines)
end

local insert_generated_commit_information = function(obj)
	vim.schedule(function()
		local lines = {}
		if obj.code ~= 0 then
			lines = { "Error running AI to generate commit message, please write your own commit message" }
		elseif obj == nil or obj.stdout == nil then
			lines = { "No output from AI, please write your own commit message" }
		else
			lines = splitText(obj.stdout)

			-- Add an empty line between the short description and the body
			table.insert(lines, 2, "")
		end

		insert_lines_at_beginning(lines)
	end)
end

vim.g.committia_hooks = {
	edit_open = function(info)
		-- If no commit message, generate one
		if info.vcs == 'git' and vim.api.nvim_buf_get_lines(0, 0, 1, false)[1] == '' then
			insert_lines_at_beginning({ WAITING_MESSAGE })
			-- Read the contents of the diff buffer
			local diff_bufnr = info.diff_bufnr
			local diff_buffer_content = vim.api.nvim_buf_get_lines(diff_bufnr, 0,
				vim.api.nvim_buf_line_count(diff_bufnr),
				false)

			-- Run the shell companion to generate the commit message
			local command = vim.system({ 'poetry', 'run', 'ai', 'git' },
				{ text = true, cwd = '/Users/aessiane/1.Projects/shell-companion/shell-companion/', stdin = true },
				insert_generated_commit_information)
			command:write(diff_buffer_content)
			command:write(nil)
		end
	end
}

--end
