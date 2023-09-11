return {
    {
        "nvim-pack/nvim-spectre",
        config = function ()
            local keymap = require("lua.config.utils").keymap

            keymap("n", "<leader>sp", ":Spectre<CR>", { desc = "Open Spectre" })
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "InsertEnter",
    }
}

