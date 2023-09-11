return {
    {
        "willothy/nvim-cokeline",
        config = function()
            local is_picking_focus = require('cokeline.mappings').is_picking_focus
            local is_picking_close = require('cokeline.mappings').is_picking_close

            require("cokeline").setup({
                components = {
                    {
                        text = " ",
                    },
                    {
                        text = function (buffer) return buffer.index end,
                    },
                    {
                        text = " ",
                    },
                    {
                        text = function(buffer)
                            return (is_picking_focus() or is_picking_close()) and buffer.pick_letter .. ' ' or buffer.devicon.icon
                        end,
                    },
                    {
                        text = " ",
                    },
                    {
                        text = function(buffer) return buffer.filename .. '  ' end,
                        style = function(buffer) return buffer.is_focused and 'bold' or nil end,
                    },
                    {
                        text = " ",
                    },
                },
            })

            local keymap = require("lua.config.utils").keymap

            keymap("n", "<A-,>", ":lua require('cokeline.mappings').by_step('focus', -1)<CR>", { desc = "Cokeline: Goto previous tab" })
            keymap("n", "<A-.>", ":lua require('cokeline.mappings').by_step('focus', 1)<CR>", { desc = "Cokeline: Goto previous tab" })

            keymap("n", "<A-<>", ":lua require('cokeline.mappings').by_step('switch', -1)<CR>", { desc = "Cokeline: Move previous tab" })
            keymap("n", "<A->>", ":lua require('cokeline.mappings').by_step('switch', 1)<CR>", { desc = "Cokeline: Move previous tab" })

            keymap("n", "<A-c>", ":lua require('cokeline.utils').buf_delete(vim.api.nvim_get_current_buf(), 'next', false)<CR>", { desc = "Cokeline: Close current buffer" })

            keymap("n", "<leader>bf", ":lua require('cokeline.mappings').pick('focus')<CR>", { desc = "Cokeline: Focus buffer picker" })
            keymap("n", "<leader>bc", ":lua require('cokeline.mappings').pick('close')<CR>", { desc = "Cokeline: Close buffer picker" })

            for i = 1,9 do
                keymap("n", ("<A-%s>"):format(i), (":lua require('cokeline.mappings').by_index('focus', %s)<CR>"):format(i), { desc = ("Cokeline: Goto tab %s"):format(i) })
            end
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
        },
    }
}

