return {
    {
        "folke/snacks.nvim",
        keys = {
            { "<leader>ex", function() Snacks.explorer.reveal() end },
        },
        lazy = false,
        priority = 3000,
        opts = {
            animate = {
                enabled = true,
            },
            bigfile = {
                enabled = true,
                line_length = 512,
                notify = true,
                size = 2.5 * 1024 * 1024,
            },
            dashboard = {
                enabled = true,
            },
            debug = {
                enabled = true,
            },
            -- dim = {
            --     enabled = true,
            -- },
            explorer = {
                enabled = true,
                replace_netrw = true,
            },
            image = {
                enabled = true,
            },
            indent = {
                enabled = false,
            },
            input = {
                enabled = true,
            },
            notifier = {
                enabled = true,
            },
            profiler = {
                enabled = true,
            },
            scroll = {},
        },
    },
}
