return {
    dependencies = {
        "neovim/nvim-lspconfig",
    },
    ft = {
        "java",
        "python"
    },
    init = function ()
        vim.lsp.config("sonarlint", {
            require("sonarlint").setup({
                filetypes = {
                    "java",
                },
                server = {
                    cmd = {
                        vim.fs.joinpath(os.getenv("JAVA_HOME"), "/bin/java"),
                        "-jar",
                        vim.fs.joinpath(vim.fn.stdpath("data"), "/mason/packages/sonarlint-language-server/extension/server/sonarlint-ls.jar"),
                        "-stdio",
                        "-analyzers",
                        vim.fs.joinpath(vim.fn.stdpath("data"), "/mason/packages/sonarlint-language-server/extension/analyzers/sonarjava.jar"),
                    },
                },
            })
        })
    end,
    url = "https://gitlab.com/schrieveslaach/sonarlint.nvim",
}
