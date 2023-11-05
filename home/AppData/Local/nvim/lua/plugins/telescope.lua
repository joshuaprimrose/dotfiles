return {
    {
        "nvim-telescope/telescope.nvim",
        config = function ()
            local telescope = require("telescope")
            local lga_actions = require("telescope-live-grep-args.actions")
            local trouble = require("trouble.providers.telescope")

            telescope.setup({
                defaults = {
                    layout_config = {
                        preview_cutoff = 120,
                        prompt_position = "top",
                        width = 0.9,
                    },
                    mappings = {
                        i = { ["<c-t>"] = trouble.open_with_trouble },
                        n = { ["<c-t>"] = trouble.open_with_trouble },
                    },
                    path_display = function (opts, path)
                        local file_name = require("telescope.utils").path_tail(path)

                        return string.format("%s … %s", file_name, path)
                    end,

                },
                extensions = {
                    aerial = {
                        show_nesting = {
                            ["_"] = false,
                            json = true,
                            yaml = true,
                        }
                    },
                    file_browser = {
                        hijack_netrw = true,
                        mappings = {

                        }
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
                                ["<C-k>"] = lga_actions.quote_prompt(),
                                ["<C-g>"] = lga_actions.quote_prompt({ postfix = " --glob "}),
                                ["<C-t>"] = lga_actions.quote_prompt({ postfix = " -t " }),
                            }
                        },
                    }
                },
            })

            telescope.load_extension("dap")
            telescope.load_extension("file_browser")
            telescope.load_extension("fzf")
            telescope.load_extension("lazygit")
            telescope.load_extension("live_grep_args")
            telescope.load_extension("aerial")

            local keymap = require("lua.config.utils").keymap

            keymap("n", "<leader>ex", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "Telescope: File Browser" })
            keymap("n", "<leader>fa", ":Telescope aerial<CR>", { desc = "Telescope: Find Aerial" })
            keymap("n", "<leader>fb", ":lua require('telescope').extensions.dap.list_breakpoints()<CR>", { desc = "Telescope: Find Breakpoints" })
            keymap("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Telescope: Find Files" })
            keymap("n", "<leader>fg", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "Telescope: Live Grep" })
            keymap("n", "<leader>ft", ":Telescope buffers<CR>", { desc = "Telescope: Find buffers" })
            keymap("n", "<leader>fh", ":Telescope help_tags<CR>", { desc = "Telescope: Find help" })
            keymap("n", "<leader>fs", ":Telescope grep_string<CR>", { desc = "Telescope: Find words" })
        end,
        dependencies = {
            "kdheepak/lazygit.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope-file-browser.nvim",
            "nvim-telescope/telescope-dap.nvim",
            "nvim-telescope/telescope-live-grep-args.nvim",
            "nvim-tree/nvim-web-devicons",
            "stevearc/aerial.nvim",
            {
                "nvim-telescope/telescope-fzf-native.nvim",
                build = "make"
            },
        },
        tag = "0.1.2",
    }
}

