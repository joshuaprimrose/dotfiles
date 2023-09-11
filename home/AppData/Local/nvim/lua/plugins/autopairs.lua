return {
    "windwp/nvim-autopairs",
    config = function ()
        local autopairs = require("nvim-autopairs")

        autopairs.setup({
            check_ts = true,  -- Enable treesitter
            ts_config = {
                java = false,                        -- Don't check treesitter in Java
                javascript = { "template_string" },  -- Don't add pairs in Javascript template_string treesitter nodes
                lua = { "string" },                  -- Don't add pairs in lua string treesitter nodes_buf
            },
        })

        -- Import nvim-autopairs completion functionality
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")

        -- Import nvim-cmp plugin (completions plugin)
        local cmp = require("cmp")

        -- Make autopairs and completion work together
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
    dependencies = {
        "hrsh7th/nvim-cmp",
    },
    event = "InsertEnter",
}

