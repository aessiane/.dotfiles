return {
    'nvim-telescope/telescope.nvim',
    -- Lazy load the plugin when this command is executed
    -- cmd = { "Telescope" },
    dependencies = {
        'nvim-lua/plenary.nvim',
        'junegunn/fzf',
        {
            'nvim-telescope/telescope-fzf-native.nvim',
            build = "make",
            config = function()
                require("telescope").load_extension("fzf")
            end,
        }
    },
}
