return {
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            current_line_blame = true,
            current_line_blame_opts = {
                delay = 500,
            },
            numhl = true,
            on_attach = function (bufnr)
                local gs = require("gitsigns")

                local function map(mode, keys, f, opts)
                    opts = opts or {}
                    opts.buffer = bufnr
                    vim.keymap.set(mode, keys, f, opts)
                end

                -- Navigation
                map("n", "]h", function ()
                    if vim.wo.diff then
                        vim.cmd.normal({ "]h", bang = true })
                    else
                        gs.nav_hunk("next")
                    end
                end, { desc = "Gitsigns: Next Hunk" })

                map("n", "[h", function ()
                    if vim.wo.diff then
                        vim.cmd.normal({ "[h", bang = true })
                    else
                        gs.nav_hunk("prev")
                    end
                end, { desc = "Gitsigns: Previous Hunk" })

                -- Actions
                map("n", "<leader>hs", gs.stage_hunk, { desc = "Gitsigns: Stage Hunk" })
                map("n", "<leader>hr", gs.reset_hunk, { desc = "Gitsigns: Reset Hunk" })

                map("n", "<leader>hS", gs.stage_buffer, { desc = "Gitsigns: Stage Buffer" })
                map("n", "<leader>hR", gs.reset_buffer, { desc = "Gitsigns: Reset Buffer" })

                map("n", "<leader>hp", gs.preview_hunk, { desc = "Gitsigns: Preview Hunk" })
                map("n", "<leader>hi", gs.preview_hunk_inline, { desc = "Gitsigns: Preview Hunk Inline" })

                map("n", "<leader>hd", gs.diffthis, { desc = "Gitsigns: Diff This" })
                -- map("n", "<leader>hD", gs.diffthis("~"), { desc = "Gitsigns: Preview Hunk Inline" })

                -- Text object
                map({'o', 'x'}, 'ih', gs.select_hunk)
            end,
            preview_config = {
                -- Options passed to nvim_open_win
                border = "shadow",
                style = "minimal",
                relative = "cursor",
                row = 1,
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
        },
    }
}
