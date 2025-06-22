return {
    "akinsho/toggleterm.nvim",
    init = function()
        local terminal = require("toggleterm.terminal").Terminal

        local get_height = function (mp)
            return math.ceil(vim.o.lines * mp)
        end

        local get_width = function (mp)
            return math.ceil(vim.o.columns * mp)
        end

        local btm = terminal:new({
            cmd = "btm",
            direction = "float",
            display_name = "Bottom System Monitor",
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

        local ntop = terminal:new({
            cmd = "ntop",
            direction = "float",
            display_name = "ntop",
            float_opts = {
                height = get_height(0.85),
                width = get_width(0.9),
                title_pos = "center",
            },
            hidden = true,
        })

        -- Toggle bottom system monitor
        vim.keymap.set("n", "<leader>tb", function ()
            btm:toggle()
        end, { desc = "Toggle bottom system monitor" })

        -- Toggle lazygit
        vim.keymap.set("n", "<leader>lg", function ()
            lazygit:toggle()
        end, { desc = "Toggle Lazygit" })

        -- Toggle ntop
        vim.keymap.set("n", "<leader>tn", function ()
            ntop:toggle()
        end, { desc = "Toggle ntop" })
    end,
    opts = {},
    version = "*",
}

