-- Bootstrap lazy.nvim
local LAZY_PATH = vim.fs.joinpath(vim.fn.stdpath("data"), "/lazy/lazy.nvim")

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

-- Set the package path so that we can run from anywhere
local CONFIG_PATH = vim.fn.stdpath("config")
package.path = vim.fs.joinpath(CONFIG_PATH, "\\?.lua;", package.path)

-- Set options
require("config.options")
-- Set highlight groups
require("config.hl_groups")
-- Set autocommands
require("config.autocommands")
-- Set keymaps
require("config.keymaps")

-- Setup lazy.nvim
require("lazy").setup({
    -- automatically check for plugin updates
    checker = { enabled = true },
    performance = {
        rtp = {
            disabled_plugins = {
                "matchit",
            },
        },
    },
    profiling = {
        loader = true,
    },
    spec = {
        { import = "plugins" },
    },
})
