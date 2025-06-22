return {
    "mason-org/mason-lspconfig.nvim",
    config = function ()
        local lspconfig = require("lspconfig")
        local capabilities = vim.lsp.protocol.make_client_capabilities()

        lspconfig.cssls.setup({
            capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

        })

        lspconfig.lua_ls.setup({})
    end,
    dependencies = {
        "hrsh7th/cmp-nvim-lsp",
        {
            "mason-org/mason.nvim",
            opts = {},
        },
        "neovim/nvim-lspconfig",
    },
    opts = {
        automatic_enable = {
            "lua_ls",
        },
        ensure_installed = {
            "lua_ls",
        },
    },
}
