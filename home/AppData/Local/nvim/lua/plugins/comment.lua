return {
    {
        "numToStr/comment.nvim",
        config = function()
            require("Comment").setup({
                mappings = {
                    basic = true,
                    extra = true,
                },
                pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
            })
        end,
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter",
        },
        event = {
            "BufReadPre",
            "BufNewFile",
        }
    }
}

