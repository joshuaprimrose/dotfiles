return {
    {
        "nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
        config = function ()
            require("nvim-treesitter").setup({
                auto_install = true,
                ensure_installed = {
                    "c",
                    "dockerfile",
                    "go",
                    "html",
                    "java",
                    "javascript",
                    "json",
                    "lua",
                    "markdown_inline",
                    "python",
                    "tsx",
                    "typescript",
                    "vim",
                    "vimdoc",
                },
                highlight = { enable = true },
                sync_install = false,
            })
        end
    }
}

