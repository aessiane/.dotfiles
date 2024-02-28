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
