--  Modes --
--  normal_mode       = "n"
--  insert_mode       = "i"
--  visual_mode       = "v"
--  visual_block_mode = "x"
--  term_mode         = "t"
--  command_mode      = "c"

local keymap = require("lua.config.utils").keymap

Normal_Mode_Indent = function(key)
    local current_mode = vim.api.nvim_get_mode()["mode"]

    if current_mode == "n" then
        vim.api.nvim_input("<SHIFT>V")
    end

    vim.api.nvim_input(key .. "gv")
end

-----------------
-- Normal Mode --
-----------------

-- Better indenting (switch to visual line mode)
keymap("n", "<", ":lua Normal_Mode_Indent('<')<CR>", { desc = "Decrease indent and keep selection" })
keymap("n", ">", ":lua Normal_Mode_Indent('>')<CR>", { desc = "Increase indent and keep selection" })

-- Move text up and down
keymap("n", "<A-j>", "<Esc>:m .+1<CR>", { desc = "Move line down one line" })
keymap("n", "<A-k>", "<Esc>:m .-2<CR>", { desc = "Move line up one line" })

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

