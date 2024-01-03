return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            require("nvim-treesitter.configs").setup({

                -- Get rid of LSP errors
                modules = {},

                ---------------------------------------------------------------
                -- Install commands
                ---------------------------------------------------------------

                -- Automatically install missing parsers when entering buffers
                auto_install = true,

                -- Ensure the following parsers are installed
                ensure_installed = {
                    "c",
                    "css",
                    "diff",
                    "dockerfile",
                    "gitcommit",
                    "gitignore",
                    "go",
                    "gomod",
                    "html",
                    "http",
                    "ini",
                    "java",
                    "javascript",
                    "jsdoc",
                    "json",
                    "jq",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "query",
                    "regex",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "yaml",
                },

                -- Do not install the following parsers
                ignore_install = {},

                -- Install parsers synchronously
                sync_install = false,

                ---------------------------------------------------------------

                -- Autotag plugin
                autotag = {
                    enable = true,
                    enable_close = true,
                    enable_close_on_slash = true,
                    enable_rename = true,
                    filetypes = {
                        "html",
                        "javascriptreact",
                        "jsx",
                        "markdown",
                        "tsx",
                        "typescriptreact",
                        "xml",
                    },
                },

                -- Highlight module
                highlight = {
                    enable = true,
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,
                },


                -- Incremental selection module
                incremental_selection = {
                    enable = true,
                    keymaps = {
                        init_selection = "gnn",
                        node_decremental = "gnk",
                        node_incremental = "gnj",
                        scope_incremental = "gsj",
                    },
                },

                -- The indent module
                indent = {
                    enable = true,
                    disable = {
                        "yaml",
                    },
                },

                -- The rainbow plugin
                rainbow = {
                    enable = true,
                    -- Also highlight non-bracket delimiters like html tags
                    extended_mode = true,
                    -- Do not enable for files with more than n lines
                    max_file_lines = 2000,
                },

                -- The textobjects plugin
                textobjects = {
                    select = {
                        enable = true,
                        keymaps = {
                            ["ai"] = { query = "@assignment.inner", desc = "Treesitter: Select inner assignment" },
                            ["ao"] = { query = "@assignment.outer", desc = "Treesitter: Select outer assignment" },
                            ["bi"] = { query = "@block.inner", desc = "Treesitter: Select inner block" },
                            ["bo"] = { query = "@block.outer", desc = "Treesitter: Select outer block" },
                            ["ci"] = { query = "@class.inner", desc = "Treesitter: Select inner class" },
                            ["co"] = { query = "@class.outer", desc = "Treesitter: Select outer class" },
                            ["fi"] = { query = "@function.inner", desc = "Treesitter: Select inner function" },
                            ["fo"] = { query = "@function.outer", desc = "Treesitter: Select outer function" },
                            ["li"] = { query = "@loop.inner", desc = "Treesitter: Select inner loop" },
                            ["lo"] = { query = "@loop.outer", desc = "Treesitter: Select outer loop" },
                            ["pi"] = { query = "@parameter.inner", desc = "Treesitter: Select inner parameter" },
                            ["po"] = { query = "@parameter.outer", desc = "Treesitter: Select outer parameter" },
                        },
                        lookahead = true,
                    },
                },
            })
        end,
        dependencies = {
            "nvim-treesitter/nvim-treesitter-textobjects",
            "p00f/nvim-ts-rainbow",
            "windwp/nvim-ts-autotag",
        },
        event = {
            "BufReadPre",
            "BufNewFile",
        }
    }
}
