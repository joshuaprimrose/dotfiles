return {
    {
        "hrsh7th/nvim-cmp",
        config = function()
            -- Here is where you configure the autocompletion settings.
            -- The arguments for .extend() have the same shape as `manage_nvim_cmp`: 
            -- https://github.com/VonHeikemen/lsp-zero.nvim/blob/v2.x/doc/md/api-reference.md#manage_nvim_cmp
            require("lsp-zero.cmp").extend()

            local cmp = require("cmp")
            local cmp_action = require("lsp-zero.cmp").action()

            cmp.setup({
                mapping = {
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<C-f>"] = cmp_action.luasnip_jump_forward(),
                    ["<C-b>"] = cmp_action.luasnip_jump_backward(),
                },
            })
        end,
        dependencies = {
            {
                "L3MON4D3/LuaSnip",
                "VonHeikemen/lsp-zero.nvim",
            },
        },
        event = "InsertEnter",
    }
}

