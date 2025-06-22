return {
    "mfussenegger/nvim-dap",
    config = function ()
        local dap = require("dap")

        ---@diagnostic disable-next-line: unused-function, unused-local
        local function attach_to_karaf()
            dap.configurations.java = {
                {
                    type = "java",
                    request = "attach",
                    name = "Attach to Karaf",
                    hostName = "localhost",
                    port = "5005",
                },
            }

            dap.continue()
        end

        vim.keymap.set("n", "<leader>dj", ":lua attach_to_karaf()<CR>", { desc = "DBG: Java Attach Debugger to Karaf" })

        vim.keymap.set("n", "<leader>bp", ":lua require('dap').toggle_breakpoint()<CR>", { desc = "DBG: Set Breakpoint" })
        vim.keymap.set("n", "<leader>do", ":lua require('dap').step_over()<CR>", { desc = "DBG: Step Over" })
        vim.keymap.set("n", "<leader>di", ":lua require('dap').step_into()<CR>", { desc = "DBG: Step Into" })
        vim.keymap.set("n", "<leader>dc", ":lua require('dap').continue()<CR>", { desc = "DBG: Continue" })
        vim.keymap.set("n", "<leader>dd", ":lua require('dap').disconnect()<CR>", { desc = "DBG: Disconnect Debugger" })
    end,
    dependencies = {
        {
            "leoluz/nvim-dap-go",
            config = function ()
                require("dap-go").setup({
                    dap_configurations = {
                        {
                            mode = "remote",
                            name = "Attach Go remote",
                            request = "attach",
                            type = "go",
                        },
                    },
                    delve = {
                        detached = vim.fn.has("win32") == 0,
                        initialize_timeout_sec = 20,
                        path = vim.fn.stdpath("data") .. "/mason/packages/delve/dlv",
                        port = "${port}",
                    },
                    tests = {
                        verbose = true,
                    }
                })
            end,
        },
    }
}

