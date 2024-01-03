return {
    {
        "folke/trouble.nvim",
        config = function ()
            local keymap = require("lua.config.utils").keymap

            keymap("n", "<leader>xd", ":TroubleToggle document_diagnostics<CR>", { desc = "Trouble: Open Document Diagnostics" })
            keymap("n", "<leader>xw", ":TroubleToggle workspace_diagnostics<CR>", { desc = "Trouble: Open Workspace Diagnostics" })
        end,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
        opts = {
            action_keys = {
                close_folds = { "fc", "fC" },
                jump_close = { "c" },
                open_code_href = "o",
                open_folds = { "fo", "fO" },
                open_split = "<C-h>",
                toggle_fold = { "ft", "fT" },
            },
        },
    }
}

