return {
    "folke/tokyonight.nvim",
    config = function ()
        local theme = require("tokyonight")

        theme.setup({
            style = "night",
            terminal_colors = true,
            transparent = true,
        })

	    vim.cmd[[colorscheme tokyonight]]
    end,
    lazy = false,
    opts = {},
    priority = 1000,
}

