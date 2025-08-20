return {
    "xzbdmw/colorful-menu.nvim",
    config = function()
        require("colorful-menu").setup({
            ls = {
                -- If true, try to highlight "not supported" languages.
                fallback = true,
                -- this will be applied to label description for unsupport languages
                fallback_extra_info_hl = "@comment",
                gopls = {
                    add_colon_before_type = true,
                    align_type_to_right = true,
                    preserve_type_when_truncate = true,
                },
                lua_ls = {
                    -- Maybe you want to dim arguments a bit.
                    arguments_hl = "@comment",
                },
                ts_ls = {
                    extra_info_hl = "@comment",
                },
            },
            fallback_highlight = "@variable",
            max_width = 75,
        })
    end,
}
