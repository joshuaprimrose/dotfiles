return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 500,
            },
            numhl = true,
            on_attach = function ()
                vim.keymap.set("n", "<leader>gtb", ":Gitsigns toggle_current_line_blame<CR>", { desc = "Gitsigns: Toggle Current Line Blame" })
                vim.keymap.set("n", "<leader>gtn", ":Gitsigns toggle_numhl<CR>", { desc = "Gitsigns: Toggle Num Highlight" })
                vim.keymap.set("n", "<leader>gtl", ":Gitsigns toggle_linehl<CR>", { desc = "Gitsigns: Toggle Line Highlight" })

                vim.keymap.set("n", "<leader>gpi", ":Gitsigns preview_hunk_inline<CR>", { desc = "Gitsigns: Preview Hunk Inline" })
                vim.keymap.set("n", "<leader>gpp", ":Gitsigns preview_hunk<CR>", { desc = "Gitsigns: Preview Hunk In Popup" })
                vim.keymap.set("n", "<leader>grh", ":Gitsigns reset_hunk", { desc = "Gitsigns: Reset Hunk" })
                vim.keymap.set("n", "]h", ":Gitsigns next_hunk<CR>", { desc = "Gitsigns: Next Hunk" })
                vim.keymap.set("n", "[h", ":Gitsigns prev_hunk<CR>", { desc = "Gitsigns: Prev Hunk" })
            end,
            preview_config = {
                -- Options passed to nvim_open_win
                border = 'single',
                style = 'minimal',
                relative = 'cursor',
                row = 0,
                col = 1
            },
            signs = {
                add          = { text = '┃' },
                change       = { text = '>' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
            signs_staged = {
                add          = { text = '┃' },
                change       = { text = '>' },
                delete       = { text = '_' },
                topdelete    = { text = '‾' },
                changedelete = { text = '~' },
                untracked    = { text = '┆' },
            },
        }
    },
    {
        "sindrets/diffview.nvim",
        init = function ()
            vim.keymap.set("n", "<leader>dfh", ":DiffviewFileHistory<CR>", { desc = "Diffview: Open file history for current branch" })
            vim.keymap.set("n", "<leader>dvo", ":DiffviewOpen<CR>", { desc = "Diffview: Open" })
            vim.keymap.set("n", "<leader>dvc", ":DiffviewClose<CR>", { desc = "Diffview: Close diffview" })
        end,
        opts = {},
    }
}

