return {
    {
        "nvim-telescope/telescope.nvim",
        config = function ()
            local action_layout = require("telescope.actions.layout")
            local action_set = require("telescope.actions.set")
            local action_state = require("telescope.actions.state")
            local file_browser_actions = require("telescope").extensions.file_browser.actions
            local lga_actions = require("telescope-live-grep-args.actions")
            local telescope = require("telescope")

            telescope.setup({
                defaults = {
                    layout_config = {
                        width = 0.9,
                    },
                    layout_strategy = "vertical",
                    mappings = {
                        i = {
                            -- Use M-h, M-j and M-k to scroll previewer
                            ["<C-d>"] = false,
                            ["<C-u>"] = false,
                            ["<M-j>"] = function (prompt_bufnr)
                                action_set.scroll_previewer(prompt_bufnr, 1)
                            end,
                            ["<M-k>"] = function (prompt_bufnr)
                                action_set.scroll_previewer(prompt_bufnr, -1)
                            end,

                            -- Use C-j and C-k to move cursor
                            ["<C-j>"] = function (prompt_bufnr)
                                action_set.shift_selection(prompt_bufnr, 1)
                            end,
                            ["<C-k>"] = function (prompt_bufnr)
                                action_set.shift_selection(prompt_bufnr, -1)
                            end,

                            -- Toggle preview
                            ["<M-p>"] = action_layout.toggle_preview,

                            -- The following function allows you to choose what window a file is opened in
                            ['<C-g>'] = function(prompt_bufnr)
                                -- Use nvim-window-picker to choose the window by dynamically attaching a function
                                local picker = action_state.get_current_picker(prompt_bufnr)
                                picker.get_selection_window = function(pkr)
                                    local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()

                                    -- Unbind after using so next instance of the picker acts normally
                                    pkr.get_selection_window = nil
                                    return picked_window_id
                                end

                                return action_set.edit(prompt_bufnr, "edit")
                            end,
                        },
                        n = {
                            -- Use M-j and M-k to scroll previewer
                            ["<C-d>"] = false,
                            ["<C-u>"] = false,
                            ["<M-j>"] = function (prompt_bufnr)
                                action_set.scroll_previewer(prompt_bufnr, 1)
                            end,
                            ["<M-k>"] = function (prompt_bufnr)
                                action_set.scroll_previewer(prompt_bufnr, -1)
                            end,

                            -- Use C-j and C-k to move cursor
                            ["j"] = false,
                            ["k"] = false,
                            ["<C-j>"] = function (prompt_bufnr)
                                action_set.shift_selection(prompt_bufnr, 1)
                            end,
                            ["<C-k>"] = function (prompt_bufnr)
                                action_set.shift_selection(prompt_bufnr, -1)
                            end,

                            -- Toggle preview
                            ["<M-p>"] = action_layout.toggle_preview,

                            -- The following function allows you to choose what window a file is opened in
                            ['<C-g>'] = function(prompt_bufnr)
                                -- Use nvim-window-picker to choose the window by dynamically attaching a function
                                local picker = action_state.get_current_picker(prompt_bufnr)
                                picker.get_selection_window = function(pkr)
                                    local picked_window_id = require("window-picker").pick_window() or vim.api.nvim_get_current_win()

                                    -- Unbind after using so next instance of the picker acts normally
                                    pkr.get_selection_window = nil
                                    return picked_window_id
                                end

                                return action_set.edit(prompt_bufnr, "edit")
                            end,
                        },
                    },
                    path_display = function (_, path)
                        local file_name = require("telescope.utils").path_tail(path)

                        return string.format("%s … %s", file_name, path)
                    end,
                    vimgrep_arguments = {
                        "rg",
                        "--color=never",
                        "--no-heading",
                        "--with-filename",
                        "--line-number",
                        "--column",
                        "--smart-case",
                        "--trim"
                    },
                },
                extensions = {
                    aerial = {
                        show_nesting = {
                            ["_"] = false,
                            json = true,
                            yaml = true,
                        },
                        sorting_strategy = "ascending",
                    },
                    file_browser = {
                        hijack_netrw = true,
                        mappings = {
                            i = {
                                ["<S-d>"] = file_browser_actions.sort_by_date,
                                ["<S-s>"] = file_browser_actions.sort_by_size,
                                ["<C-s>"] = function (prompt_bufnr)
                                    action_set.shift_selection(prompt_bufnr, 0)
                                    print("selected")
                                end,
                            },
                            n = {
                                ["<S-d>"] = file_browser_actions.sort_by_date,
                                ["<S-s>"] = file_browser_actions.sort_by_size,
                            },
                        },
                    },
                    fzf = {
                        fuzzy = true,
                        override_generic_sorter = true,
                        override_file_sorter = true,
                        case_mode = "smart_case",
                    },
                    live_grep_args = {
                        auto_quoting = true,
                        mappings = {
                            i = {
                                ["<C-q>"] = lga_actions.quote_prompt(),
                                ["<C-g>"] = lga_actions.quote_prompt({ postfix = " --glob "}),
                                ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t " }),
                            },
                            n = {
                                ["<C-q>"] = lga_actions.quote_prompt(),
                                ["<C-g>"] = lga_actions.quote_prompt({ postfix = " --glob "}),
                                ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t " }),
                            },
                        },
                    }
                },
                pickers = {
                    find_files = {
                        find_command = {
                            "fd",
                            "--type",
                            "f",
                            "--strip-cwd-prefix"
                        },
                    },
                },
                theme = "dropdown",
            })

            telescope.load_extension("aerial")
            telescope.load_extension("dap")
            telescope.load_extension("file_browser")
            telescope.load_extension("fzf")
            telescope.load_extension("lazygit")
            telescope.load_extension("live_grep_args")
        end,
        dependencies = {
            "folke/trouble.nvim",
            "kdheepak/lazygit.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-dap.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make",
            },
            "nvim-telescope/telescope-live-grep-args.nvim",
            "nvim-tree/nvim-web-devicons",
            "s1n7ax/nvim-window-picker",
            "stevearc/aerial.nvim",
        },
        tag = "0.1.2",
    }
}
