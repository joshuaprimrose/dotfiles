return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    event = {
        "BufReadPre",
        "BufNewFile",
    },
    opts = {
        auto_install = true,
        ensure_installed = {
            "diff",
            "go",
            "html",
            "java",
            "javascript",
            "jq",
            "jsdoc",
            "json",
            "lua",
            "markdown",
            "markdown_inline",
            "powershell",
            "sql",
            "templ",
            "tsx",
            "typescript",
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
    },
}

