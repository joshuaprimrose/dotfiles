return {
    dependencies = {
        "neovim/nvim-lspconfig",
    },
    ft = {
        "java",
    },
    init = function ()
        vim.lsp.config("sonarlint", {
            require("sonarlint").setup({
                filetypes = {
                    "java",
                },
                server = {
                    cmd = {
                        "C:/EngTools/Java/jdk-23/bin/java",
                        "-jar",
                        vim.fn.stdpath("data") .. "/mason/packages/sonarlint-language-server/extension/server/sonarlint-ls.jar",
                        "-stdio",
                        "-analyzers",
                        vim.fn.stdpath("data") .. "/mason/packages/sonarlint-language-server/extension/analyzers/sonarjava.jar",
                    },
                },
            })
        })
    end,
    url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
}

