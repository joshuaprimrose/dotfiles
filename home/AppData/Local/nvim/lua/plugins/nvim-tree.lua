return {
    {
        "nvim-tree/nvim-tree.lua",
        config = function ()
            vim.g.loaded_netrwPlugin = 1
            vim.g.loaded_netrw = 1

            local keymap = require("lua.config.utils").keymap

            local nvim_tree = require("nvim-tree")

            nvim_tree.setup({
                filters = {
                    dotfiles = true,
                },
                sort_by = "case_sensitive",
                view = {
                    width = 30,
                },
            })

            keymap("n", "<leader>nt", ":NvimTreeToggle<CR>", { desc = "Toggle Nvim Tree" })
        end,
        dependencies = {
            "nvim-tree/nvim-web-devicons",
        },
    }
}

