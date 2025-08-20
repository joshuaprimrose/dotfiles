return {
    {
        "mfussenegger/nvim-dap",
        config = function ()
            vim.api.nvim_set_hl(0, 'DapBreakpoint', { ctermbg = 0, fg = "#993939", bg = "#31353f" })
            vim.api.nvim_set_hl(0, 'DapLogPoint', { ctermbg = 0, fg = "#61afef", bg = "#31353f" })
            vim.api.nvim_set_hl(0, 'DapStopped', { ctermbg = 0, fg = "#98c379", bg = "#31353f" })

            vim.fn.sign_define('DapBreakpoint', { text="●", texthl="DapBreakpoint", linehl="DapBreakpoint", numhl="DapBreakpoint" })
            vim.fn.sign_define('DapBreakpointCondition', { text="ﳁ", texthl="DapBreakpoint", linehl="DapBreakpoint", numhl="DapBreakpoint" })
            vim.fn.sign_define('DapBreakpointRejected', { text="", texthl="DapBreakpoint", linehl="DapBreakpoint", numhl= "DapBreakpoint" })
            vim.fn.sign_define('DapLogPoint', { text="", texthl="DapLogPoint", linehl="DapLogPoint", numhl= "DapLogPoint" })
            vim.fn.sign_define('DapStopped', { text="", texthl="DapStopped", linehl="DapStopped", numhl= "DapStopped" })

            local dap = require "dap"
            local ui = require "dapui"

            require("dapui").setup({})
            require("dap-go").setup({})
            require("nvim-dap-virtual-text").setup({})

            local nmap = require("utils.general_utils").nmap

            nmap("<leader>dui", ui.toggle, { desc = "Debug: Toggle UI" })

            nmap("<leader>b", dap.toggle_breakpoint, { desc = "Debug: Set Breakpoint" })
            nmap("<leader>cb", function ()
                vim.ui.input({ default = "", prompt = "Please enter the condition: " }, function (condition)
                    if condition == "" then
                        return
                    end

                   vim.ui.input({ default = "", prompt = "Please enter your log message [Enter for condition]: " }, function (message)
                        if message ~= "" then
                            vim.api.nvim_command(":lua require('dap').toggle_breakpoint(condition, nil, condition)")
                        else
                            vim.api.nvim_command(":lua require('dap').toggle_breakpoint(condition, nil, message)")
                        end
                    end)
                end)
            end, { desc = "Debug: Set Conditional Breakpoint" })
            nmap("<leader>gb", dap.run_to_cursor, { desc = "Debug: Run To Cursor" })
            nmap("<leader>d*", function ()
                ui.eval(nil, { enter = true })
            end, { desc = "Debug: Evaluate Under Cursor" })

            nmap("<F1>", dap.continue, { desc = "Debug: Start/Continue" })
            nmap("<F2>", dap.step_into, { desc = "Debug: Step Into" })
            nmap("<F3>", dap.step_over, { desc = "Debug: Step Over" })
            nmap("<F3>", dap.step_out, { desc = "Debug: Step Out" })
            nmap("<F3>", dap.step_back, { desc = "Debug: Step Back" })
            nmap("<F12>", dap.restart, { desc = "Debug: Restart" })

            dap.configurations.java = {
                {
                    name = "Attach to Karaf",
                    type = "java",
                    request = "attach",
                    hostName = "localhost",
                    port = 5005,
                },
            }

            dap.configurations.lua = {
                {
                    name = "Current file (local-lua-dbg, neovim lua interpreter with nlua)",
                    type = "lua-local",
                    request = "launch",
                    cwd = "${workspaceFolder}",
                    program = {
                        lua = "nlua",
                        file = "${file}",
                    },
                    args = {},
                },
                {
                    name = "Current file (local-lua-dbg, lua)",
                    type = "lua-local",
                    request = "launch",
                    cwd = "${workspaceFolder}",
                    program = {
                        lua = "lua5.4",
                        file = "${file}",
                    },
                    args = {},
                },
            }

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end

            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end

            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end

            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end

            -- dap.listeners.after.event_breakpoint.dapui_config = function ()
            --     dapui.update_render({
            --         indent = 1,
            --         max_type_length = 100,
            --     })
            -- end
        end,
        dependencies = {
            "leoluz/nvim-dap-go",
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
            "theHamsta/nvim-dap-virtual-text",
            "williamboman/mason.nvim",
        },
    }
}
