return {
    {
        "folke/trouble.nvim",
        config = function ()
            local keymap = require("lua.config.utils").keymap

            keymap("n", "<leader>xx", ":TroubleToggle<CR>", { desc = "Trouble: Toggle Trouble Window" })
            keymap("n", "<leader>xw", ":TroubleToggle workspace_diagnostics<CR>", { desc = "Trouble: Open Workspace Diagnostics" })
            keymap("n", "<leader>xd", ":TroubleToggle document_diagnostics<CR>", { desc = "Trouble: Open Document Diagnostics" })
            keymap("n", "<leader>xq", ":TroubleToggle quickfix<CR>", { desc = "Trouble: Open Quickfix" })
            keymap("n", "<leader>xl", ":TroubleToggle loclist<CR>", { desc = "Trouble: Open Loclist" })
            keymap("n", "<leader>xr", ":TroubleToggle lsp_references<CR>", { desc = "Trouble: Open LSP References" })
    end,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        }
    }
}

