return {
    {
        "akinsho/toggleterm.nvim",
        init = function()
            local terminal = require("toggleterm.terminal").Terminal

            local get_height = function (mp)
                return math.ceil(vim.o.lines * mp)
            end

            local get_width = function (mp)
                return math.ceil(vim.o.columns * mp)
            end

            local btop = terminal:new({
                cmd = "btop",
                direction = "float",
                display_name = "BTOP System Monitor",
                float_opts = {
                    height = get_height(0.85),
                    width = get_width(0.9),
                    title_pos = "center",
                },
                hidden = true,
            })

            local lazygit = terminal:new({
                cmd = "lazygit",
                direction = "float",
                display_name = "Lazygit",
                float_opts = {
                    height = get_height(0.85),
                    width = get_width(0.9),
                    title_pos = "center",
                },
                hidden = true,
            })

            vim.keymap.set("n", "<leader>tb", function ()
                btop:toggle()
            end, { desc = "Toggle BTOP System Monitor" })

            -- Toggle lazygit
            vim.keymap.set("n", "<leader>lg", function ()
                lazygit:toggle()
            end, { desc = "Toggle Lazygit" })
        end,
        opts = {},
        version = "*",
    }
}
