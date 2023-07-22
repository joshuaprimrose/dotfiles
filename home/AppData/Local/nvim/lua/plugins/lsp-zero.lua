return {
    {
        "VonHeikemen/lsp-zero.nvim",
        config = function()
            require("lsp-zero.settings").preset({})
        end,
        lazy = true,
    }
}

