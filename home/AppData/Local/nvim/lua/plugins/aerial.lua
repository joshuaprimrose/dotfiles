return {
    {
        "stevearc/aerial.nvim",
        config = function ()
            local aerial = require("aerial")

            aerial.setup({
                layout = {
                    max_width = { 100, 0.2 },
                    width = 60
                },

                on_attach = function ()
                    local keymap = require("lua.config.utils").keymap

                    keymap("n", "<leader>af", ":AerialToggle float<CR>", { desc = "Aerial: Open floating Aerial" })
                    keymap("n", "<leader>al", ":AerialToggle left<CR>", { desc = "Aerial: Toggle left Aerial" })
                    keymap("n", "<leader>ar", ":AerialToggle right<CR>", { desc = "Aerial: Toggle right Aerial" })

                    keymap("n", "[", ":AerialPrev<CR>", { desc = "Aerial: " })
                    keymap("n", "]", ":AerialNext<CR>", { desc = "Aerial: " })
                    keymap("n", "<leader>ac", ":AerialCloseAll<CR>", { desc = "Aerial: Close all Aerial windows"})
                end
            })
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter",
            "nvim-tree/nvim-web-devicons"
        },
        opts = {},
    }
}

