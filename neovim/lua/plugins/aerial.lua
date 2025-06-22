return {
    {
        "stevearc/aerial.nvim",
        keys = {
            { "<leader>ar", ":AerialToggle<CR>", desc = "Aerial: Toggle" },
        },
        opts = {
            close_automatic_events = {
                "switch_buffer",
                "unfocus",
            },
        },
        dependencies = {
        "nvim-treesitter/nvim-treesitter",
        "nvim-tree/nvim-web-devicons",
        },
    }
}

