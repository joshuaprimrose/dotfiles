return {
    {
        "neovim/nvim-lspconfig",
        cmd = "LspInfo",
        config = function()
            local lsp = require("lsp-zero")
            local lspconfig = require("lspconfig")

            lsp.on_attach(function(_, bufnr)
                lsp.default_keymaps({ buffer = bufnr })
            end)

            lsp.skip_server_setup({ "jdtls" })

            lspconfig.lua_ls.setup(lsp.nvim_lua_ls())
        end,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason-lspconfig.nvim",
            {
                "williamboman/mason.nvim",
                build = ":MasonUpdate",
            },
        },
        event = {
            "BufReadPre",
            "BufNewFile",
        },
    }
}

