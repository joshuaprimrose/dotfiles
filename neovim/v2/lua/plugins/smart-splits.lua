return {
    {
        "mrjones2014/smart-splits.nvim",
        init = function ()
            require("smart-splits").setup({
                cursor_follows_swapped_bufs = true,
                default_amount = 2,
                ignored_buftypes = {
                    "prompt",
                },
            })

            local nmap = require("utils.general_utils").nmap

            ---------- Create Splits ----------
            nmap("<leader>sw", function ()
                vim.api.nvim_command("vsplit")
            end, { desc = "Splits: Split Left" })

            nmap("<leader>nh", function ()
                vim.api.nvim_command("vnew")
            end, { desc = "Splits: New Split Left" })

            nmap("<leader>sj", function ()
                vim.api.nvim_command("set splitbelow")
                vim.api.nvim_command("split")
                vim.api.nvim_command("set nosplitbelow")
            end, { desc = "Splits: Split Down" })

            nmap("<leader>nj", function ()
                vim.api.nvim_command("set splitbelow")
                vim.api.nvim_command("new")
                vim.api.nvim_command("set nosplitbelow")
            end, { desc = "Splits: New Split Down" })

            nmap("<leader>sk", function ()
                vim.api.nvim_command("split")
            end, { desc = "Splits: Split Up" })

            nmap("<leader>nk", function ()
                vim.api.nvim_command("new")
            end, { desc = "Splits: New Split Above" })

            nmap("<leader>sl", function ()
                vim.api.nvim_command("set splitright")
                vim.api.nvim_command("vsplit")
                vim.api.nvim_command("set nosplitright")
            end, { desc = "Splits: Split Right" })

            nmap("<leader>nl", function ()
                vim.api.nvim_command("set splitright")
                vim.api.nvim_command("vnew")
                vim.api.nvim_command("set nosplitright")
            end, { desc = "Splits: New Split Right" })

            ---------- Move Between Splits ----------
            nmap("<C-h>", "<C-w>h", { desc = "Move Left" })
            nmap("<C-j>", "<C-w>j", { desc = "Move Down" })
            nmap("<C-k>", "<C-w>k", { desc = "Move Up" })
            nmap("<C-l>", "<C-w>l", { desc = "Move Right" })

            ---------- Resize Splits ----------
            nmap("<C-S-h>", require("smart-splits").resize_left, { desc = "Splits: Resize Left" })
            nmap("<C-S-j>", require("smart-splits").resize_down, { desc = "Splits: Resize Down" })
            nmap("<C-S-k>", require("smart-splits").resize_up, { desc = "Splits: Resize Up" })
            nmap("<C-S-l>", require("smart-splits").resize_right, { desc = "Splits: Resize Right" })

            ---------- Swap Buffers ----------
            nmap("<leader><leader>h", require("smart-splits").swap_buf_left, { desc = "Splits: Swap With Left" })
            nmap("<leader><leader>j", require("smart-splits").swap_buf_down, { desc = "Splits: Swap With Below" })
            nmap("<leader><leader>k", require("smart-splits").swap_buf_up, { desc = "Splits: Swap With Above" })
            nmap("<leader><leader>l", require("smart-splits").swap_buf_right, { desc = "Splits: Swap With Right" })
        end,
    }
}
