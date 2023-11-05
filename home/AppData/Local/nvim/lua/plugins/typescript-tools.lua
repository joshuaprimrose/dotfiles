return {
    {
        "pmizio/typescript-tools.nvim",
        config = function ()
            local keymap = require("lua.config.utils").keymap

            require("typescript-tools").setup({
                on_attach = function(_, bufnr)
                    keymap("n", "<leader>ca", ":lua vim.lsp.buf.code_action()<CR>", { buffer = bufnr, desc = "LSP: Code Action" })
                    keymap("n", "<leader>oi", ":TSToolsOrganizeImports<CR>", { buffer = bufnr, desc = "LSP: Organize Imports" })
                end,
                settings = {
                    expose_as_code_action = "all",
                }
            })
        end,
        dependencies = {
            "neovim/nvim-lspconfig",
            "nvim-lua/plenary.nvim",
        },
        opts = {},
    }
}
