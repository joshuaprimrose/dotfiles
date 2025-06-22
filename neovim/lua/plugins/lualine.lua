return {
    "nvim-lualine/lualine.nvim",
    dependencies = {
        "nvim-tree/nvim-web-devicons",
    },
    opts = function ()
        local color_utils = require("lua.utils.color-utils")

        local colors = {
            bg                = "#202328",
            fg                = "#000000",
            chili_red         = "#D64933",
            dark_spring_green = "#0C7C59",
            lapis_lazuli      = "#006494",
            maize             = "#F5E663",
            plum              = "#963484",
            white             = "#FFFFFf",
        }

        local conditions = {
            buffer_not_empty = function()
                return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
            end,
            hide_in_width = function()
                return vim.fn.winwidth(0) > 80
            end,
            check_git_workspace = function()
                local filepath = vim.fn.expand('%:p:h')
                local gitdir = vim.fn.finddir('.git', filepath .. ';')
                return gitdir and #gitdir > 0 and #gitdir < #filepath
            end,
        }

        local filename_wicon = require("lualine.components.filename"):extend()
        filename_wicon.apply_icon = require("lualine.components.filetype").apply_icon

        local mode_color = {
            c = colors.maize,
            i = colors.dark_spring_green,
            n = colors.plum,
            R = colors.chili_red,
            s = colors.dark_spring_green,
            v = colors.lapis_lazuli,
            V = colors.lapis_lazuli,
            ["^V"] = colors.lapis_lazuli,
        }

        local mode = {
            "mode",
            color = function ()
                return {
                    bg = mode_color[vim.fn.mode()],
                    fg = colors.fg,
                }
            end,
            separator = {
                left = "",
                right = "",
            },
        }

        local hostname = {
            "hostname",
            color = {
                bg = colors.bg,
                fg = colors.white,
            },
            padding = {
                left = 2,
                right = 2,
            },
        }

        local branch = {
            "branch",
            color = {
                bg = colors.bg,
                fg = colors.white,
            },
            cond = conditions.check_git_workspace,
            padding = {
                left = 0,
                right = 2,
            },
        }

        local branch_spacer = {
            function ()
                return "  "
            end,
            cond = function ()
                return (not conditions.check_git_workspace())
            end,
            color = function ()
                return {
                    bg = colors.bg,
                }
            end,
        }

        local filename = {
            filename_wicon,
            color = function ()
                return {
                    bg = mode_color[vim.fn.mode()],
                    fg = colors.fg,
                }
            end,
            cond = conditions.buffer_not_empty,
            padding = {
                left = conditions.check_git_workspace() and 0 or 2,
                right = 2,
            },
            separator = {
                left = "",
                right = "",
            },
        }

        local filesize = {
            "filesize",
            color = function ()
                return {
                    bg = mode_color[vim.fn.mode()],
                    fg = colors.fg,
                }
            end,
            cond = conditions.buffer_not_empty,
            padding = {
                left = 0,
                right = 2,
            },
            separator = {
                left = "",
                right = "",
            },
        }

        local progress = {
            "progress",
            color = function ()
                local col = mode_color[vim.fn.mode()]

                return {
                    -- bg = color_utils.darken(col, 16),
                    bg = colors.bg,
                    fg = colors.white,
                }
            end,
            cond = conditions.buffer_not_empty,
            padding = {
                left = 2,
                right = 1,
            },
        }

        local location = {
            "location",
            color = {
                bg = colors.bg,
                fg = colors.white,
            },
            cond = conditions.buffer_not_empty,
            padding = {
                left = 0,
                right = 2,
            },
        }

        local searchcount = {
            "searchcount",
            color = {
                bg = colors.bg,
                fg = colors.white,
            },
            cond = conditions.buffer_not_empty,
            padding = {
                left = 0,
                right = 2,
            },
        }

        local lsp = {
            function()
                local msg = "No Active Lsp"
                local buf_ft = vim.bo.filetype
                local clients = vim.lsp.get_clients()

                if next(clients) == nil then
                    return msg
                end

                for _, client in ipairs(clients) do
                    local filetype = client.get_language_id(_, buf_ft)

                    if filetype == buf_ft then
                        return client.name
                    end
                end

                return msg
            end,
            color = function()
                return {
                    bg = mode_color[vim.fn.mode()],
                    fg = colors.fg,
                }
            end,
            icon = "LSP:",
            padding = {
                left = 2,
                right = 1,
            },
            separator = {
                left = "",
                right = "",
            },
        }

        local function getColor(m)
            return mode_color[m]
        end

        local diagnostics = {
            "diagnostics",
            color = function ()
                return {
                    bg = mode_color[vim.fn.mode()],
                    fg = colors.fg,
                }
            end,
            padding = {
                left = 1,
                right = 2,
            },
            separator = {
                right = "",
            },
        }

        return {
            options = {
                component_separators = "",
                icons_enabled = true,
                section_separators = "",
                theme = "catppuccin",
            },
            sections = {
                lualine_a = {
                    mode,
                    hostname,
                    branch,
                    -- branch_spacer,
                    filename,
                    filesize,
                    progress,
                    location,
                    searchcount,
                },
                lualine_b = {
                    lsp,
                    diagnostics,
                },
                lualine_c = {
                    {
                        "buffers",
                        cond = conditions.buffer_not_empty,
                    },
                },

                lualine_x = {

                },
                lualine_y = {

                },
                lualine_z = {

                },
            },
        }
    end,
}
