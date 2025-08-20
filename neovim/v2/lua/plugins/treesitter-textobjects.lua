return {
    {
        "nvim-treesitter/nvim-treesitter-textobjects",
        config = function ()
            require("nvim-treesitter.configs").setup({
                textobjects = {
                    move = {
                        enable = true,
                        goto_next_start = {
                            ["]a"] = { query = "@assignment.outer", desc = "TextObjects: Move to start of next assignment" },
                            ["]f"] = { query = "@function.outer", desc = "TextObjects: Move to start of next function" },
                            ["]i"] = { query = "@conditional.outer", desc = "TextObjects: Move to start of next conditional" },
                            ["]l"] = { query = "@loop.outer", desc = "TextObjects: Move to start of next loop" },
                        },
                    },
                    select = {
                        enable = true,
                        lookahead = true,
                        keymaps = {
                            ["l="] = { query = "@assignment.lhs", desc = "TextObjects: Select Left-Hand Side of an Assignment" },
                            ["r="] = { query = "@assignment.rhs", desc = "TextObjects: Select Right Hand-Side of an Assignment" },
                            ["i="] = { query = "@assignment.inner", desc = "TextObjects: Select Inner Assignment" },
                            ["a="] = { query = "@assignment.outer", desc = "TextObjects: Select Outer Assignment" },

                            ["ic"] = { query = "@class.inner", desc = "TextObjects: Select Inner Class" },
                            ["ac"] = { query = "@class.outer", desc = "TextObjects: Select Outer Class" },

                            ["if"] = { query = "@function.inner", desc = "TextObjects: Select Inner Function" },
                            ["af"] = { query = "@function.outer", desc = "TextObjects: Select Outer Function" },

                            ["ii"] = { query = "@conditional.inner", desc = "TextObjects: Select Inner Conditional" },
                            ["ai"] = { query = "@conditional.outer", desc = "TextObjects: Select Outer Conditional" },

                            ["il"] = { query = "@loop.inner", desc = "TextObjects: Select Inner Loop" },
                            ["al"] = { query = "@loop.outer", desc = "TextObjects: Select Outer Loop" },
                        },
                    },
                },
            })
        end,
        lazy = true,
    },
}
