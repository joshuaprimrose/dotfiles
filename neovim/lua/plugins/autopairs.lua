return {
    {
        "windwp/nvim-autopairs",
        config = function ()
            require("nvim-autopairs").setup({
                check_comma = true,
                check_ts = true,        -- Use treesitter to check for pairs
                disable_filetype = {
                    "TelescopePrompt"
                },
                fast_wrap = {
                    map = "<M-w>",
                },
                ts_config = {
                    java = false,                        -- Don't check treesitter in Java
                    javascript = { "template_string" },  -- Don't add pairs in Javascript template_string treesitter nodes
                    lua = { "string" },                  -- Don't add pairs in lua string treesitter nodes_buf
                },
            })
        end,
        event = "InsertEnter",
    }
}

