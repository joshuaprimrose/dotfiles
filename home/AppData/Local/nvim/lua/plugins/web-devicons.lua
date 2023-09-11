return {
    {
        "nvim-tree/nvim-web-devicons",
        config = function()
            local icons = require("nvim-web-devicons")

            icons.setup({
                override = {
                    package_installed = {
                        icon = "",
                        color = "#00ffff",
                        name = "package_installed",
                    },
                    package_pending = {
                        icon = "󰦖",
                        color = "#ffff00",
                        name = "package_pending",
                    },
                    package_uninstalled = {
                        icon = "󱂑",
                        color = "#ff0000",
                        name = "package_uninstalled",
                    },
                },
            })
        end,
        lazy = false,
    }
}

