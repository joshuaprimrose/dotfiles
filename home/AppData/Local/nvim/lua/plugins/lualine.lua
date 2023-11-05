return {
    {
        "nvim-lualine/lualine.nvim",
        config = function ()
            local lualine = require("lualine")

            lualine.setup({
                options = {
                    icons_enabled = true,
                    theme = "tokyonight",
                },
                sections = {
                    lualine_a = {
                        "mode",
                    },
                    lualine_b = {
                        "branch",
                        "diff",
                        "diagnostics",
                    },
                    lualine_c = {
                        "aerial",
                    }
                },
            })
        end,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    }
}

