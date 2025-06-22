return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = {
        { 
            "<leader>/",
            function() require("which-key").show({ global = true }) end,
            desc = "Which Key: Show local key maps",
        },
    },
    opts = {
        filter = function(mapping)
            return mapping.desc and mapping.desc ~= ""
        end,
        preset = "modern",
    },
}
