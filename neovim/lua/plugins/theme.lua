return {
    "catppuccin/nvim",
    config = function ()
        require("catppuccin").setup({
            dim_inactive = {
                enabled = true,
            },
            flavour = "mocha", -- latte, frappe, macchiato, mocha, auto
            integrations = {
                cmp = true,
                dap = true,
                dap_ui = true,
                gitsigns = true,
                mason = true,
                native_lsp = {
                    enabled = true,
                    inlay_hints = {
                        background = true,
                    },
                },
                treesitter = true,
                which_key = true,
            },
            show_end_of_buffer = true,
            transparent_background = true,
        })

        vim.cmd.colorscheme("catppuccin")

        vim.api.nvim_set_hl(0, "LineNr", { fg = "#ffee8c", bold = true })
    end,
    lazy = false,
    name = "catppuccin",
    priority = 1000,
}
