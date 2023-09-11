return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local treesitter = require("nvim-treesitter.configs")

            treesitter.setup({
                auto_install = true,
                autotag = {
                    enable = true,
                },
                context_commentstring = {
                    enable = true,
                },
                ensure_installed = {
                    "c",
                    "dockerfile",
                    "go",
                    "html",
                    "java",
                    "javascript",
                    "json",
                    "lua",
                    "markdown_inline",
                    "python",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "yaml",
                },
                highlight = {
                    additional_vim_regex_highlighting = true,
                    disable = {
                        "",
                    },
                    enable = true
                },
                ignore_install = {},
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-Space>",
                        node_decremental = "<C-S-Space>",
                        node_incremental = "<C-Space>",
                        scope_incremental = "<C-s>",
                    },
                },
                indent = {
                    disable = {
                        "yaml",
                    },
                    enable = true,
                },
                modules = {},
                move = {
                    enable = true,
                    goto_next_end = {
                        ["]c"] = "@class.outer",
                        ["]f"] = "@function.outer",
                    },
                    goto_next_start = {
                        ["]C"] = "@class.outer",
                        ["]F"] = "@function.outer",
                    },
                    goto_previous_end = {
                        ["[c"] = "@class.outer",
                        ["[f"] = "@function.outer",
                    },
                    goto_previous_start = {
                        ["[C"] = "@class.outer",
                        ["[F"] = "@function.outer",
                    },
                    set_jumps = true,
                },
                swap = {
                    enable = true,
                    swap_next = {
                        ["}s"] = "@parameter.inner",
                    },
                    swap_previous = {
                        ["{s"] = "@parameter.inner",
                    },
                },
                sync_install = false,
                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                            ["ci"] = "@class.inner",
                            ["co"] = "@class.outer",
                            ["fi"] = "@function.inner",
                            ["fo"] = "@function.outer",
                            ["pi"] = "@parameter.inner",
                            ["po"] = "@parameter.outer",
                        },
                        lookahead = true,
                    },
                },
            })
        end,
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "windwp/nvim-ts-autotag",
        },
        event = {
            "BufReadPre",
            "BufNewFile",
        },
    }
}

