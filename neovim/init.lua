-- Bootstrap lazy.nvim
local LAZY_PATH = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(LAZY_PATH) then local LAZY_REPO = "https://github.com/folke/lazy.nvim.git"
    local OUT = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        LAZY_REPO,
        LAZY_PATH
    })

    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { OUT, "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end

-- Prepend the runtime path with the lazy path
vim.opt.rtp:prepend(LAZY_PATH)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

-- Set the package path so taht we can run from anywhere
local CONFIG_PATH = vim.fn.stdpath("config")
package.path = CONFIG_PATH .. "\\?.lua;" .. package.path

vim.cmd[[let g:codeium_server_config = {
  \'portal_url': 'https://codeium.devlnk.net',
  \'api_url': 'https://codeium.devlnk.net/_route/api_server' }
]]

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function ()
        vim.highlight.on_yank({ higroup = "@text.warning", timeout = 500 })
    end,
})

vim.api.nvim_create_autocmd("TermOpen", {
    callback = function ()
        vim.opt.number = false
        vim.opt.relativenumber = false
    end,
    group = vim.api.nvim_create_augroup("custom-term-open", { clear = true })
})

vim.keymap.set("n", "<leader>nt", function ()
    vim.cmd.term()
    vim.cmd("startinsert")

    local job_id = vim.bo.channel
    vim.fn.chansend(job_id, { "nu\r\n" })
    -- Need to add nu syntax file to silicon https://github.com/stevenxxiu/sublime_text_nushell/blob/master/nushell.sublime-syntax
    -- for terminal screenshots to work properly
    vim.bo.filetype = "nu"

    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit insert mode" })
end, { desc = "Open a NuShell terminal" })

vim.keymap.set("n", "<leader>pt", function ()
    vim.cmd.term()
    vim.cmd("startinsert")

    local job_id = vim.bo.channel
    vim.fn.chansend(job_id, { "pwsh\r\n" })
    vim.bo.filetype = "ps1"

    vim.keymap.set("t", "<Esc>", "<C-\\><C-n>", { desc = "Exit insert mode" })
end, { desc = "Open a PowerShell terminal" })

-- Set options
require("lua.config.options")
-- Set keymaps
require("lua.config.keymaps")

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- automatically check for plugin updates
    checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "matchit",
            },
        },
    },
})
