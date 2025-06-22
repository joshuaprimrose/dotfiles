return {
    "folke/trouble.nvim",
    cmd = "Trouble",
    keys = {
        {
            "<leader>xx",
            ":Trouble diagnostics toggle filter.buf=0<CR>",
            desc = "Trouble: Show Buffer Diagnostics",
        },
        {
            "<leader>xs",
            ":Trouble symbols toggle focus=true win.position=left<CR>",
            desc = "Trouble: Show LSP Symbols",
        },
    },
    opts = {},
}
