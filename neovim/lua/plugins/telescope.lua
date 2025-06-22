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
        "smartpde/telescope-recent-files",
    },
    init = function()
        local actions_set = require("telescope.actions.set")
        local live_grep_actions = require("telescope-live-grep-args.actions")
        local sorters = require("telescope.sorters")
        local telescope = require("telescope")
        local textcase = require("textcase")

        local format_path = function (path)
            local file_name = require("telescope.utils").path_tail(path)

            return string.format("%s … %s", file_name, path)
        end

        textcase.setup({})

        telescope.setup({
            defaults = {
                file_ignore_patterns = {
                    "^.git/*",
                    "^node_modules/*",
                    ".terraform.lock.hcl",
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
                        ["<PageDown>"] = function (bufnr)
                            actions_set.scroll_previewer(bufnr, 1)
                        end,
                        -- Use Page Up to scroll the previewer
                        ["<C-u>"] = false,
                        ["<PageUp>"] = function (bufnr)
                            actions_set.scroll_previewer(bufnr, -1)
                        end
                    },
                    n = {
                        -- Use Page Down to scroll the previewer
                        ["<C-d>"] = false,
                        ["<PageDown>"] = function (bufnr)
                            actions_set.scroll_previewer(bufnr, 1)
                        end,
                        -- Use Page Up to scroll the previewer
                        ["<C-u>"] = false,
                        ["<PageUp>"] = function (bufnr)
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
                    theme = "catppuccin",
                },
                recent_files = {
                    initial_mode = "normal",
                }
            },
        })

        telescope.load_extension("file_browser")
        telescope.load_extension("fzf")
        telescope.load_extension("live_grep_args")
        telescope.load_extension("recent_files")
        telescope.load_extension("textcase")
    end,
    keys = {
        { "<leader>f/", ":Telescope current_buffer_fuzzy_find<CR>", desc = "Telescope: Fuzzy Find In Current Buffer" },
        { "<leader>fb", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", desc = "Telescope: File Browser" },
        { "<leader>fc", ":TextCaseOpenTelescope<CR>", desc = "Telescope: Text Case" },
        { "<leader>fd", ":Telescope definitions<CR>", desc = "Telescope: Goto Definition (Word Under Cursor)" },
        { "<leader>ff", ":Telescope find_files hidden=true<CR>", desc = "Telescope: Find Files" },
        { "<leader>fg", ":Telescope live_grep_args<CR>", desc = "Telescope: Live Grep" },
        { "<leader>fh", ":Telescope help_tags<CR>", desc = "Telescope: Search Help" },
        { "<leader>fi", ":Telescope lsp_implementations<CR>", desc = "Telescope: Goto Implementation (Word Under Cursor)" },
        { "<leader>fm", ":Telescope marks<CR>", desc = "Telescope: Marks" },
        { "<leader>fr", ":lua require('telescope').extensions.recent_files.pick()<CR>", desc = "Telescope: Recent Files" },
        { "<leader>fs", ":Telescope lsp_document_symbols<CR>", desc = "Telescope: Find Document Symbols" },
        { "<leader>ft", ":Telescope treesitter<CR>", desc = "Telescope: Treesitter List Functions & Variables" },
        { "<leader>fw", ":Telescope buffers<CR>", desc = "Telescope: Find Buffers" },
        { "<leader>f*", ":lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor_current_buffer()<CR>", "Telescope: Grep Word Under Cursor (Current Buffer)" },
        { "<leader>fe*", ":lua require('telescope-live-grep-args.shortcuts').grep_word_under_cursor()<CR>", "Telescope: Grep Word Under Cursor" },
    }
}
