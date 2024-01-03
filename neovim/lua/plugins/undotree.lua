return {
    {
        "mbbill/undotree",
        config = function ()
            local keymap = require("lua.config.utils").keymap

            keymap("n", "<leader>u", ":UndotreeToggle<CR>", { desc = "Undotree: Toggle" })
        end,
    }
}

