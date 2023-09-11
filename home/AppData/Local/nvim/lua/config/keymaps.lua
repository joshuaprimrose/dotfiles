--  Modes --
--  normal_mode       = "n"
--  insert_mode       = "i"
--  visual_mode       = "v"
--  visual_block_mode = "x"
--  term_mode         = "t"
--  command_mode      = "c"

local keymap = require("lua.config.utils").keymap

-----------------
-- Normal Mode --
-----------------

-- Create splits
keymap("n", "<leader>sh", ":split<CR>", { desc = "Split horizontal" })
keymap("n", "<leader>sv", ":vsplit<CR>", { desc = "Split vertical" })

-- Manage splits
keymap("n", "<leader>=", "<C-w>=", { desc = "Make alll splits equal size" })
keymap("n", "<leader>c", "<C-w>q", { desc = "Close split" })
keymap("n", "<leader>co", ":only<CR>", { desc = "Close all other splits" })

-- Move around splits using Ctrl + {h,j,k,l}
keymap("n", "<C-h>", "<C-w>h")
keymap("n", "<C-j>", "<C-w>j")
keymap("n", "<C-k>", "<C-w>k")
keymap("n", "<C-l>", "<C-w>l")

-- Tabs
keymap("n", "<leader>to", ":tabnew<CR>", { desc = "Open new tab" })
keymap("n", "<leader>tx", ":tabclose<CR>", { desc = "Close current tab" })
keymap("n", "<leader>tn", ":tabn<CR>", { desc = "Go to next tab" })
keymap("n", "<leader>tp", ":tabp<CR>", { desc = "Go to previous tab" })
keymap("n", "<leader>tf", ":tabnew %<CR>", { desc = "Open current buffer in new tab" })

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>", { desc = "Move line down one line" })
keymap("n", "<A-k>", "<Esc>:m .-2<CR>", { desc = "Move line up one line" })

-- Resize windows
keymap("n", "<C-Up>",    ":resize -2<CR>", { desc = "Resize window up" })
keymap("n", "<C-Down>",  ":resize +2<CR>", { desc = "Resize window down" })
keymap("n", "<C-Left>",  ":vertical resize +2<CR>", { desc = "Resize window left" })
keymap("n", "<C-Right>", ":vertical resize -2<CR>", { desc = "Resize window right" })

-------------------
-- Terminal Mode --
-------------------



-----------------
-- Visual Mode --
-----------------

-- Move text up and down
keymap("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down one line" })
keymap("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up one line" })

-- Stay in indent mode
keymap("v", "<", "<gv", { desc = "Decrease indent and keep selection" })
keymap("v", ">", ">gv", { desc = "Increase indent and keep selection" })

