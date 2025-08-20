return {
    {
        "sindrets/diffview.nvim",
        init = function ()
            vim.keymap.set("n", "<leader>dvh", ":DiffviewFileHistory<CR>", { desc = "Diffview: Open file history for current branch" })
            vim.keymap.set("n", "<leader>dvo", ":DiffviewOpen<CR>", { desc = "Diffview: Open" })
            vim.keymap.set("n", "<leader>dvc", ":DiffviewClose<CR>", { desc = "Diffview: Close diffview" })
        end,
        opts = {},
    }
}
