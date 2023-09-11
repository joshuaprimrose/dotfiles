return {
    {
        "kdheepak/lazygit.nvim",
        config = function ()
            local keymap = require("lua.config.utils").keymap

            keymap("n", "<leader>lg", ":LazyGit<CR>", { desc = "Open LazyGit" })
            keymap("n", "<leader>lgc", ":LazyGitConfig<CR>", { desc = "Open LazyGit Config File" })
        end,
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
    }
}

