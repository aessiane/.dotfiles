return {
    'nvim-treesitter/nvim-treesitter',
    build = ":TSUpdate",
    config = function()
        local configs = require("nvim-treesitter.configs")

        configs.setup({
            -- ensure these language parsers are installed
            ensure_installed = {
                "bash",
                "css",
                "c",
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
                "rust",
                "vimdoc",
                "sql",
                "terraform",
                "toml",
                "typescript",
                "vim",
                "yaml"
            },
            sync_install = true,
            highlight = { enable = true },
            indent = { enable = true },
            -- install parsers synchronously
            sync_install = false,
        })
    end
}
