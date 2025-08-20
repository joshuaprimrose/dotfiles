---@diagnostic disable: missing-fields

return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        config = function ()
            require("nvim-treesitter.configs").setup({
                auto_install = true,
                ensure_installed = {
                    "bash",
                    "c",
                    "css",
                    "csv",
                    "diff",
                    "dockerfile",
                    "go",
                    "gomod",
                    "gosum",
                    "gotmpl",
                    "gowork",
                    "html",
                    "http",
                    "java",
                    "javadoc",
                    "javascript",
                    "jsdoc",
                    "json",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "powershell",
                    "python",
                    "query",
                    "sql",
                    "templ",
                    "toml",
                    "tsx",
                    "typescript",
                    "vim",
                    "xml",
                    "yaml",
                },
                autotag = {
                    enable = true,
                },
                highlight = {
                    enable = true,
                    -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
                    -- If you are experiencing weird indenting issues, add the language to
                    -- the list of additional_vim_regex_highlighting and disabled languages for indent.
                    additional_vim_regex_highlighting = {
                        "ruby"
                    },
                },
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "<C-Space>",
                        node_incremental = "<C-Space>",
                        scope_incremental = "<C-A-Space>",
                        node_decremental = "<BS>",
                    },
                },
            })

            vim.keymap.set("n", "<leader>it", ":InspectTree<CR>", { desc = "Treesitter: Inspect Tree" })
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            {
                "windwp/nvim-ts-autotag",
                config = function ()
                    require("nvim-ts-autotag").setup({
                        per_filetype = {
                            ["html"] = {
                                enable_close = true,
                                enable_rename = true,
                                enable_close_on_slash = true,
                            },
                            ["javascript"] = {
                                enable_close = true,
                                enable_rename = true,
                                enable_close_on_slash = true,
                            },
                            ["jsx"] = {
                                enable_close = true,
                                enable_rename = true,
                                enable_close_on_slash = true,
                            },
                            ["markdown"] = {
                                enable_close = true,
                                enable_rename = true,
                                enable_close_on_slash = true,
                            },
                            ["templ"] = {
                                enable_close = true,
                                enable_rename = true,
                                enable_close_on_slash = true,
                            },
                            ["tsx"] = {
                                enable_close = true,
                                enable_rename = true,
                                enable_close_on_slash = true,
                            },
                            ["typescript"] = {
                                enable_close = true,
                                enable_rename = true,
                                enable_close_on_slash = true,
                            },
                            ["xml"] = {
                                enable_close = true,
                                enable_rename = true,
                                enable_close_on_slash = true,
                            },
                        }
                    })
                end,
            },
        },
        event = {
            "BufReadPre",
            "BufNewFile"
        },
    }
}
