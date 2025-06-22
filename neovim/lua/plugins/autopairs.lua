return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
    --     check_comma = true,
    --     check_ts = false,
        disable_filetype = {
            "ps1",
            "TelescopePrompt",
        },
        disable_in_macro = true,
    --     fast_wrap = {
    --         map = "<leader>ww",
    --     },
    --     ts_config = {
    --         java = false,
    --         javascript = {
    --             "tempalate_string",
    --         },
    --         lua = {
    --             "string",
    --         },
    --     },
    },
}

