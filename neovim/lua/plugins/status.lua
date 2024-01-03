return {
    {
        "nvim-lualine/lualine.nvim",
        config = function ()
            local lualine = require("lualine")
            local hydra_statusline = require('hydra.statusline')

            local function hydra_status()
                if hydra_statusline.is_active() then
                    return hydra_statusline.get_name()
                else
                    return ""
                end
            end

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
                        "filename",
                        "filesize",
                    },
                    lualine_c = {
                        "branch",
                        "diff",
                        "diagnostics",
                    },
                    lualine_d = {
                        "aerial",
                    },
                    lualine_e = {
                        hydra_status,
                    },

                    lualine_x = {
                        "encoding",
                        "filetype",
                    }
                },
            })
        end,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    }
}
