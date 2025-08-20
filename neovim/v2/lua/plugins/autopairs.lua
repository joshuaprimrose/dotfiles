return {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {
        disable_filetype = {
            "ps1",
            "TelescopePrompt",
        },
        disable_in_macro = true,
    },
}
