vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Set the package path so that we can open from anywhere
local CONFIG_PATH = vim.fn.stdpath("config")
package.path = CONFIG_PATH .. "\\?.lua;" .. package.path

require("lua.config.options")
require("lua.config.keymaps")

-- Bootstrap lazy
local LAZY_PATH = vim.fn.stdpath("data") .. "\\lazy\\lazy.nvim"
if not vim.loop.fs_stat(LAZY_PATH) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        LAZY_PATH
    })
end

-- Prepend the runtime path with the lazy path
vim.opt.rtp:prepend(LAZY_PATH)

require("lazy").setup({
    spec = {
	{ import = "plugins" },
    },
})

