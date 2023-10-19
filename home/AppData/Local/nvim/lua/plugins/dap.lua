return {
    {
        "mfussenegger/nvim-dap",
        config = function ()
            local dap_ui = require("dapui")
            local keymap = require("lua.config.utils").keymap

            require("neodev").setup({
                library = {
                    plugins = {
                        "nvim-dap-ui"
                    },
                    types = true,
                },
            })

            dap_ui.setup()
            keymap("n", "<leader>dt", ":lua require('dapui').toggle()<CR>", { desc = "Debug UI: Toggle Debugger UI" })

            -- Debugger
            keymap("n", "<F5>", ":lua require('dap').continue()<CR>", { desc = "Debug: Continue" })
            keymap("n", "<F6>", ":lua require('dap').step_over()<CR>", { desc = "Debug: Step Over" })
            keymap("n", "<F7>", ":lua require('dap').step_into()<CR>", { desc = "Debug: Step Into" })
            keymap("n", "<F8>", ":lua require('dap').step_out()<CR>", { desc = "Debug: Step Out" })
            keymap("n", "<leader>b", ":lua require('dap').toggle_breakpoint()<CR>", { desc = "Debug: Toggle Breakpoint" })
            keymap("n", "<leader>B", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint Condition: ')<CR>", { desc = "Debug: Toggle Conditional Breakpoint" })
        end,
        dependencies = {
            "folke/neodev.nvim",
            "rcarriga/cmp-dap",
            "rcarriga/nvim-dap-ui",
        }
    }
}

