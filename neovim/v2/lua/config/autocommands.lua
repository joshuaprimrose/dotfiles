-- Highlight yanked text
vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function ()
        vim.highlight.on_yank({ higroup = "@text.warning", timeout = 500 })
    end,
})

-- Hide line numbers in terminal, enter insert mode, and make Esc exit insert mode
vim.api.nvim_create_autocmd("TermOpen", {
    callback = function ()
        vim.opt_local.number = false
        vim.opt_local.relativenumber = false
        vim.opt_local.signcolumn = "no"

        vim.cmd("startinsert")

        vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit insert mode", noremap = true, silent = true })
    end,
    group = vim.api.nvim_create_augroup("custom-term-open", { clear = true })
})

-- Auto-resize splits when window is resized
vim.api.nvim_create_autocmd("VimResized", {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})
