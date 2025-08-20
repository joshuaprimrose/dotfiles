return {
    "nvim-telescope/telescope.nvim",
    dependencies = {
        "johmsalas/text-case.nvim",
        {
            "nvim-telescope/telescope-file-browser.nvim",
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
        },
        {
            "nvim-telescope/telescope-fzf-native.nvim",
            build = "make",
            dependencies = {
                "nvim-lua/plenary.nvim",
            },
        },
        "nvim-telescope/telescope-live-grep-args.nvim",
        "nvim-telescope/telescope-ui-select.nvim",
        "smartpde/telescope-recent-files",
    },
    init = function()
        local actions_set = require("telescope.actions.set")
        local live_grep_actions = require("telescope-live-grep-args.actions")
        local sorters = require("telescope.sorters")
        local telescope = require("telescope")
        local textcase = require("textcase")

        local format_path = function(path)
            local file_name = require("telescope.utils").path_tail(path)

            return string.format("%s … %s", file_name, path)
        end

        textcase.setup({})

        telescope.setup({
            defaults = {
                file_ignore_patterns = {
                    "^.\\git/",
                    "node_modules",
                    "%.class",
                    "%.project",
                    "%.terraform.lock.hcl",
                },
                file_sorter = sorters.get_generic_fuzzy_sorter,
                layout_config = {
                    vertical = {
                        height = 0.9,
                        preview_cutoff = 30,
                        prompt_position = "bottom",
                        width = 0.9,
                    }
                },
                layout_strategy = "vertical",
                mappings = {
                    i = {
                        -- Use Page Down to scroll the previewer
                        ["<C-d>"] = false,
                        ["<PageDown>"] = function(bufnr)
                            actions_set.scroll_previewer(bufnr, 1)
                        end,
                        -- Use Page Up to scroll the previewer
                        ["<C-u>"] = false,
                        ["<PageUp>"] = function(bufnr)
                            actions_set.scroll_previewer(bufnr, -1)
                        end
                    },
                    n = {
                        -- Use Page Down to scroll the previewer
                        ["<C-d>"] = false,
                        ["<PageDown>"] = function(bufnr)
                            actions_set.scroll_previewer(bufnr, 1)
                        end,
                        -- Use Page Up to scroll the previewer
                        ["<C-u>"] = false,
                        ["<PageUp>"] = function(bufnr)
                            actions_set.scroll_previewer(bufnr, -1)
                        end
                    },
                },
                path_display = function(_, path)
                    return format_path(path)
                end,
                pickers = {
                    buffers = {
                        initial_mode = "normal",
                    },
                },
                sorting_strategy = "ascending",
                theme = "center",
                vimgrep_arguments = {
                    "rg",
                    "--hidden",
                    "--line-number",
                    "--smart-case",
                    "--trim",
                    "--vimgrep",
                },
            },
            extensions = {
                file_browser = {
                    initial_mode = "normal",
                },
                live_grep_args = {
                    mappings = {
                        i = {
                            ["<C-g>"] = live_grep_actions.quote_prompt({ postfix = " -ig  *." }),
                            ["<C-t>"] = live_grep_actions.quote_prompt({ postfix = " -it " }),
                        },
                    },
                    -- theme = "dropdown",
                },
                recent_files = {
                    initial_mode = "normal",
                },
                ["ui-select"] = {
                    require('telescope.themes').get_dropdown(),
                }
            },
        })

        telescope.load_extension("file_browser")
        telescope.load_extension("fzf")
        telescope.load_extension("live_grep_args")
        telescope.load_extension("recent_files")
        telescope.load_extension("textcase")
        telescope.load_extension("ui-select")
    end,
    keys = {
        {
            "<leader>f/",
            ":Telescope current_buffer_fuzzy_find<CR>",
            desc = "Telescope: Fuzzy Find In Current Buffer",
            silent = true,
        },
        {
            "<leader>fb",
            ":Telescope file_browser path=%:p:h select_buffer=true<CR>",
            desc = "Telescope: File Browser",
            silent = true,
        },
        {
            "<leader>fc",
            ":TextCaseOpenTelescope<CR>",
            desc = "Telescope: Text Case",
            silent = true,
        },
        {
            "<leader>fd",
            ":Telescope definitions<CR>",
            desc = "Telescope: Goto Definition (Word Under Cursor)",
            silent = true,
        },
        {
            "<leader>ff",
            ":Telescope find_files hidden=true<CR>",
            desc = "Telescope: Find Files",
            silent = true,
        },
        {
            "<leader>fg",
            ":Telescope live_grep_args<CR>",
            desc = "Telescope: Live Grep",
            silent = true,
        },
        {
            "<leader>fh",
            ":Telescope help_tags<CR>",
            desc = "Telescope: Search Help",
            silent = true,
        },
        {
            "<leader>fi",
            ":Telescope lsp_implementations<CR>",
            desc = "Telescope: Goto Implementation (Word Under Cursor)",
            silent = true,
        },
        {
            "<leader>fm",
            ":Telescope marks<CR>",
            desc = "Telescope: Marks",
            silent = true,
        },
        {
            "<leader>fr",
            ":lua require('telescope').extensions.recent_files.pick()<CR>",
            desc = "Telescope: Recent Files",
            silent = true,
        },
        {
            "<leader>fs",
            function ()
                require('telescope.builtin').lsp_document_symbols({ symbols = { 'function', 'method' } })
            end,
            desc = "Telescope: Find Document Symbols",
            silent = true,
        },
        {
            "<leader>ft",
            ":Telescope treesitter<CR>",
            desc = "Telescope: Treesitter List Functions & Variables",
            silent = true,
        },
        {
            "<leader>fw",
            ":Telescope buffers<CR>",
            desc = "Telescope: Find Buffers",
            silent = true,
        },
        {
            "<leader>f*",
            ":lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor_current_buffer()<CR>",
            desc = "Telescope: Grep Word Under Cursor (Current Buffer)",
            silent = true,
        },
        {
            "<leader>fe*",
            ":lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<CR>",
            desc = "Telescope: Grep Word Under Cursor",
            silent = true,
        },
    }
}
