return {
    {
        "chentoast/marks.nvim",
        config = function ()
            require("marks").setup({
                force_write_shada = true,
            })
        end,
    }
}

