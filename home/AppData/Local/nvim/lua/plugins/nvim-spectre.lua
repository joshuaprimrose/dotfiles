return {
    {
        "nvim-pack/nvim-spectre",
        config = function ()
            local keymap = require("lua.config.utils").keymap

            keymap("n", "<leader>sp", ":lua require('spectre').toggle()<CR>", { desc = "Toggle Spectre" })
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        event = "InsertEnter",
    }
}

