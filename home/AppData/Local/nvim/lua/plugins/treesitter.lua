

return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            local treesitter = require("nvim-treesitter.configs")
            local keymap = require("lua.config.utils").keymap

            treesitter.setup({

                -- Get rid of lsp warnings
                ignore_install = {},
                modules = {},

                ---------------------------------------------------------------------------
                -- Install commands

                -- Automatically install missing parsers when entering buffers
                auto_install = true,

                -- Ensure the following parsers are installed
                ensure_installed = {
                    "bash",
                    "c",
                    "diff",
                    "dockerfile",
                    "go",
                    "html",
                    "java",
                    "javascript",
                    "jsdoc",
                    "json",
                    "jq",
                    "lua",
                    "markdown",
                    "markdown_inline",
                    "python",
                    "query",
                    "regex",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                    "yaml",
                },

                -- Install parsers synchronously
                sync_install = false,

                ---------------------------------------------------------------------------


                ---------------------------------------------------------------------------
                -- Modules/Plugins

                -- Autopair plugin
                autopairs = {
                    enable = true,
                },

                -- Autotag plugin
                autotag = {
                    -- Enable autotagging
                    enable = true,

                    -- Enable tag renamimg
                    enable_rename = true,

                    -- Enable close
                    enable_close = true,

                    -- Enable close on slash
                    enable_close_on_slash = true,

                    -- Setup for the following filetypes
                    filetypes = {
                        "html",
                        "javascript",
                        "javascriptreact",
                        "jsx",
                        "markdown",
                        "tsx",
                        "typescript",
                        "typescriptreact",
                        "xml",
                    }
                },

                -- The highlight module
                highlight = {
                    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
                    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
                    -- Using this option may slow down your editor, and you may see some duplicate highlights.
                    -- Instead of true it can also be a list of languages
                    additional_vim_regex_highlighting = false,

                    -- Disable highlighting for...
                    disable = {},

                    -- Enable the highlight module
                    enable = true,
                },

                -- The incremental selection module
                incremental_selection = {
                    -- Enable incremental selection
                    enable = true,
                    
                    -- Setup keymaps
                    keymaps = {
                        init_selection = "<CR>",
                        node_incremental = "<CR>",
                        scope_incremental = "gsi",
                        node_decremental = "<BS>",
                    },
                },

                -- The indent plugin
                indent = {
                    -- Enable the indent plugin
                    enable = true,

                    -- Disable the indent plugin for the following types
                    disable = {
                        "yaml",
                    },
                },

                -- The rainbow plugin
                rainbow = {
                    -- Enable the rainbow plugin
                    enable = true,

                    -- Also highlight non-bracket delimiters like html tags
                    extended_mode = true,

                    -- Do not enable for files with more than n lines
                    max_file_lines = 2000,
                },

                -- The textobjects plugin
                textobjects = {
                    select = {
                        -- Enable textobjects plugin
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

                ---------------------------------------------------------------------------
            })

            -- Add some keymaps
            keymap("n", "<leader>ic", ":Inspect<CR>", { desc = "Treesitter: Inspect highlight group under cursor" })
            keymap("n", "<leader>it", ":InspectTree<CR>", { desc = "Treesitter: Inspect Tree" })
        end,
        dependencies = {
            "JoosepAlviste/nvim-ts-context-commentstring",
            "nvim-treesitter/nvim-treesitter-textobjects",
            "p00f/nvim-ts-rainbow",
            "windwp/nvim-ts-autotag",
        },
        event = {
            "BufReadPre",
            "BufNewFile",
        },
    }
}

