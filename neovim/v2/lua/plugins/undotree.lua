return {
    {
        "jiaoshijie/undotree",
        config = function()
            require("undotree").setup({
                float_diff = false,
                layout = "left_bottom",
                window = {
                    winblend = 30,
                },
            })

            vim.keymap.set("n", "<leader>u", ":lua require('undotree').toggle()<CR>", { desc = "Undotree: Toggle Undo Tree" })
        end,
        dependencies = "nvim-lua/plenary.nvim",
    }
}
