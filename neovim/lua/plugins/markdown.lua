return {
    "MeanderingProgrammer/render-markdown.nvim",
    config = function ()
        require('render-markdown').setup({})

        vim.keymap.set("n", "<leader>md", ":RenderMarkdown toggle<CR>", { desc = "Render Markdown: Toggle" })
    end,
    dependencies = {
        "nvim-treesiter/nvim-treesitter",
    },
}
