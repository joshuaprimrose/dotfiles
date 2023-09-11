return {
    {
        "rcarriga/nvim-dap-ui",
        config = function ()
            local dap_ui = require("dapui")
            local keymap = require("lua.config.utils").keymap

            dap_ui.setup()

            -- Debugger
            keymap("n", "<F5>", ":lua require('dap').continue()<CR>", { desc = "Debug: Continue" })
            keymap("n", "<F10>", ":lua require('dap').step_over()<CR>", { desc = "Debug: Step Over" })
            keymap("n", "<F11>", ":lua require('dap').step_into()<CR>", { desc = "Debug: Step Into" })
            keymap("n", "<F12>", ":lua require('dap').step_out()<CR>", { desc = "Debug: Step Out" })
            keymap("n", "<leader>b", ":lua require('dap').toggle_breakpoint()<CR>", { desc = "Debug: Toggle Breakpoint" })
            keymap("n", "<leader>B", ":lua require('dap').set_breakpoint(vim.fn.input('Breakpoint Condition: ')<CR>", { desc = "Debug: Toggle Conditional Breakpoint" })

            keymap("n", "<leader>du", ":lua require('dapui').toggle()<CR>", { desc = "Debug: Toggle Debug UI" })
        end,
        dependencies = {
            "mfussenegger/nvim-dap",
        }
    }
}

