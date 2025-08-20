return {
    "kylechui/nvim-surround",
    config = function ()
        require("nvim-surround").setup()
    end,
    event = "VeryLazy",
    version = "^3.0.0",
}
