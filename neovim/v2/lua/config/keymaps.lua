local map = require("utils.general_utils").map
local nmap = require("utils.general_utils").nmap

---------------------------------------- Normal Mode ----------------------------------------

-- Clear search highlights on Esc
nmap("<Esc>", "<Cmd>nohlsearch<CR>", { desc = "Clear search highlights" })

-- Edit init.lua file
nmap("<leader>ec", "<Cmd>e ~/.config/nvim/init.lua<CR>", { desc = "Edit init.lua" })

-- Additional paste options
nmap("<leader>pa", "<Cmd>pu!<CR>", { desc = "Paste on line above" })
nmap("<leader>pb", "<Cmd>pu<CR>", { desc = "Paste on line below" })

-- Better indenting
nmap("<", "<<", { desc = "Decrease indent" })
nmap(">", ">>", { desc = "Increase indent" })

-- Center vertically when searching/paging
nmap("n", "nzzzv", { desc = "Next search result (centered)" })
nmap("N", "Nzzzv", { desc = "Previous search result (centered)" })
nmap("<C-d>", "<C-d>zz")
nmap("<C-u>", "<C-u>zz")
nmap("<PageDown>", "<PageDown>zz")
nmap("<PageUp>", "<PageUp>zz")

-- Move text up and down
nmap("<A-j>", "<Esc><Cmd>m .+1<CR>==", { desc = "Move line down one line" })
nmap("<A-k>", "<Esc><Cmd>m .-2<CR>==", { desc = "Move line up one line" })

-- Run last substitution command
nmap("&", "<Cmd>&&<CR>", { desc = "Run the last substitution" })
nmap("<leader>n", "n&", { desc = "Find next and run the last substitution" })
nmap("<leader>N", "N&", { desc = "Find previous and run the last substitution" })

-- Change buffers
nmap("<A-,>", "<Cmd>bp<CR>", { desc = "Prev Buffer" })
nmap("<A-.>", "<Cmd>bn<CR>", { desc = "Next Buffer" })

-- Close current buffer
nmap("<leader>q", "<Cmd>bd<CR>", { desc = "Close current buffer" })
nmap("<leader>Q", "<Cmd>bd!<CR>", { desc = "Close current buffer no warn" })

-- Delete to black hole register
nmap("<leader>D", "\"_dd", { desc = "Delete to black hole register" })

-- Toggle Twilight
nmap("<leader>dm", "<Cmd>Twilight<CR>", { desc = "Twilight: Toggle Twilight" })
-- nmap("<leader>dm", "function() Snacks.dim() end", { desc = "Twilight: Toggle Twilight" })


---------------------------------------- Insert Mode ----------------------------------------

-- Paste while in insert mode
map("i", "<C-v>", "<Esc>\"+pa", { desc = "Paste while in insert mode" })

---------------------------------------- Visual & Select Mode ----------------------------------------

-- Move text up and down
map("x", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down one line" })
map("x", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up one line" })

-- Stay in visual mode and keep selection when indenting
map("x", "<", "<gv", { desc = "Decrease indent and keep selection" })
map("x", ">", ">gv", { desc = "Increase indent and keep selection" })

---------------------------------------- Terminal Mode ----------------------------------------


---------------------------------------- Useful Functions ----------------------------------------

-- Copy full file path
nmap("<leader>cp", function ()
    local path = vim.fn.expand("%:p")
    vim.fn.setreg("+", path)
    print("Path to current file:", path)
end)

-- Toggle word wrap
nmap("<leader>ww", function ()
    local currentStr = vim.api.nvim_get_option_value("wrap", { scope = "global" })
    if currentStr == true then
        vim.api.nvim_set_option_value("wrap", false, { scope = "global" })
        print("wrap = false")
    else
        vim.api.nvim_set_option_value("wrap", true, { scope = "global" })
        print("wrap = true")
    end
end, { desc = "Toggle word wrap", silent = true })

