return {
    {
        "anuvyklack/hydra.nvim",
        config = function ()
            local hydra = require("hydra")

            function Git_Or_Fallback ()
                local call_git_files = require("lua.config.utils").call_git_files()

                if call_git_files == true then
                    vim.api.nvim_command("Telescope git_files")
                else
                    vim.api.nvim_command("Telescope find_files")
                end
            end

            local git_hint = [[
             ^
                    Lazygit                   Telescope
             ^
               _l_: Lazygit                _b_: Branches
               _f_: Lazygit Config         _c_: Commits
                                         _h_: Stash
                                         _s_: Status
                                         _w_: Buffer Commits             ^
            ]]

            hydra({
                body = "<leader>v",
                config = {
                    color = "teal",
                    hint = {
                        border = "shadow",
                        position = "middle",
                    },
                    invoke_on_body = true,
                },
                heads = {
                    { "b", ":Telescope git_branches<CR>", { desc = "Telescope: Git Branches" } },
                    { "c", ":Telescope git_commits<CR>", { desc = "Telescope: Git Commits" } },
                    { "h", ":Telescope git_stash<CR>", { desc = "Telescope: Git Stash" } },
                    { "l", ":LazyGit<CR>", { desc = "LazyGit: Open Lazygit" } },
                    { "f", ":LazyGitConfig<CR>", { desc = "LazyGit: Open Lazygit Config File" } },
                    { "s", ":Telescope git_status<CR>", { desc = "Telescope: Git Status" } },
                    { "w", ":Telescope git_bcommits<CR>", { desc = "Telescope: Git Buffer Commits" } },

                    -- Exit this Hydra
                    { "<Esc>", nil, { exit = true, nowait = true } },
                },
                hint = git_hint,
                mode = "n",
                name = "Git",
            })

            local telescope_hint = [[
             ^
                             _a_: Aerial            _b_: Breakpoints
                🬭🬭🬭🬭🬭🬭🬭🬭🬼    _c_: Command History   _f_: Find Files
               █        █    _g_: Live Grep         _j_: Jumplist
               █ ▁     █🬾   _m_: Marks             _o_: Old/Recent Files
              ██🬿       ██   _v_: Git Files         _w_: Windows/Buffers
              █🬝🮄🮄🮄🮄🮄🮄🮄🮄🬆█   _x_: File Browser      _z_: Fuzzy Find Current Buffer     ^
               🬺🬹🬱🬭🬭🬭🬭🬵🬹🬹█   _?_: Help
                             
                             _<Enter>_: List Pickers
            ]]

            hydra({
                body = "<leader>f",
                config = {
                    color = "teal",
                    hint = {
                        border = "shadow",
                        position = "middle",
                    },
                    invoke_on_body = true,
                },
                heads = {
                    { "a", ":Telescope aerial<CR>", { desc = "Telescope: Aerial" } },
                    { "b", ":lua require('telescope').extensions.dap.list_breakpoints()<CR>", { desc = "Telescope: Find Breakpoints"} },
                    { "c", "Telescope command_history<CR>", { desc = "TelescopeL Command History"} },
                    { "f", ":Telescope find_files<CR>", { desc = "Telescope: Find Files" } },
                    { "g", ":lua require('telescope').extensions.live_grep_args.live_grep_args()<CR>", { desc = "Telescope: Live Grep"} },
                    { "j", ":Telescope jumplist<CR>", { desc = "Telescope: Jumplist" } },
                    { "m", ":Telescope marks<CR>", { desc = "Telescope: Find Marks"} },
                    { "o", ":Telescope oldfiles<CR>", { desc = "Telescope: Find Recently Opened Files" } },
                    { "v", ":lua Git_Or_Fallback()<CR>", { desc = "Telescope: Git / Find Files" } },
                    { "w", ":Telescope buffers<CR>", { desc = "Telescope: Find Buffers" } },
                    { "x", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "Telescope: File Browser" } },
                    { "z", ":Telescope current_buffer_fuzzy_find<CR>", { desc = "Telescope: Fuzzy Find (Current Buffer)" } },
                    { "?", ":Telescope help_tags<CR>", { desc = "Telescope: Find Help" } },
                    -- Open Telescope Picker List
                    { "<Enter>", ":Telescope<CR>", { desc = "Telescope: Picker List" } },

                    -- Exit this Hydra
                    { "<Esc>", nil, { exit = true, nowait = true } },
                },
                hint = telescope_hint,
                mode = "n",
                name = "Telescope",
            })

            local window_manager_hint = [[
                   Manage Windows               Create Splits              Move Between Windows      Resize Windows     

            _c_  Close active window       _n_  Create new split                        _k_                       _K_          
            _co_ Close all other windows   _hs_ Create horizontal split               _h_   _l_                   _H_   _L_   
            _e_  Equalize windows          _vs_ Create vertical split                   _j_                       _J_          
            ]]

            hydra({
                body = "<C-w>",
                config = {
                    color = "pink",
                    invoke_on_body = true,
                    hint = {
                        border = "shadow",
                        offset = -1,
                        position = "middle",
                    },
                },
                heads = {
                    -- Close active window
                    { "c", ":q<CR>" },
                    { "co", ":only<CR>" },

                    -- Create splits
                    { "n", ":new<CR>" },
                    { "hs", ":split<CR>" },
                    { "vs", ":vsplit<CR>" },

                    -- Equalize window sizes
                    { "e", "<C-w>=" },

                    -- Move between windows
                    { "h", "<C-w>h" },
                    { "j", "<C-w>j" },
                    { "k", "<C-w>k" },
                    { "l", "<C-w>l" },

                    -- Resizing window
                    { "H", ":vertical resize -2<CR>" },
                    { "J", ":resize +2<CR>" },
                    { "K", ":resize -2<CR>" },
                    { "L", ":vertical resize +2<CR>" },

                    -- Exit this Hydra
                    { "<Esc>", nil, { exit = true, nowait = true } },
                },
                hint = window_manager_hint,
                mode = "n",
                name = "Window Management",
            })
        end,
        dependencies = {
            "kdheepak/lazygit.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
        }
    },
}

