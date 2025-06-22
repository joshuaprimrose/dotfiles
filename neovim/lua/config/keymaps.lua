---------- Modes ----------
--  normal_mode       = "n"
--  insert_mode       = "i"
--  visual_mode       = "v"
--  visual_block_mode = "x"
--  term_mode         = "t"
--  command_mode      = "c"
---------------------------


---------------------------------------- Normal Mode ----------------------------------------

-- Better indenting
vim.keymap.set("n", "<", "<<", { desc = "Decrease indent" })
vim.keymap.set("n", ">", ">>", { desc = "Increase indent" })

--  Better Page Up/Down
vim.keymap.set("n", "<PageDown>", "<PageDown>zz")
vim.keymap.set("n", "<PageUp>", "<PageUp>zz")

-- Close current buffer
vim.keymap.set("n", "<leader>q", ":bd<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>Q", ":bd!<CR>", { desc = "Close current buffer no warn" })

-- Delete to black hole register
vim.keymap.set("n", "<leader>d", "\"_dd", { desc = "Delete to black hole register" })

-- Move text up and down
vim.keymap.set("n", "<A-j>", "<Esc>:m .+1<CR>", { desc = "Move line down one line" })
vim.keymap.set("n", "<A-k>", "<Esc>:m .-2<CR>", { desc = "Move line up one line" })

-- Run last substitution command
vim.keymap.set("n", "&", ":&&", { desc = "Run the last substitution" })

-- Override J for joining lines
-- vim.keymap.set("n", "J", "", {})

-- Changing buffers
vim.keymap.set("n", "<A-,>", ":bp<CR>", { desc = "Prev Buffer" })
vim.keymap.set("n", "<A-.>", ":bn<CR>", { desc = "Next Buffer" })

-- Create new splits
vim.keymap.set("n", "<leader>hn", ":new<CR>", { desc = "Create new horizontal split" })
vim.keymap.set("n", "<leader>vn", ":vnew<CR>", { desc = "Create new vertical split" })

-- Create duplicate splits
vim.keymap.set("n", "<leader>hs", ":split<CR>", { desc = "Create horizontal split" })
vim.keymap.set("n", "<leader>vs", ":vsplit<CR>", { desc = "Create horizontal split" })

-- Moving between splits
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move  to the left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to the window below" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to the window above" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to the right window" })

-- Change size of splits
vim.keymap.set("n", "<C-Up>", function ()
    local lines = math.ceil(vim.o.lines * 0.05)
    vim.api.nvim_exec2(string.format(":res +%.2f", lines), {})
end, { desc = "Increase height" })

vim.keymap.set("n", "<C-Down>", function ()
    local lines = math.ceil(vim.o.lines * 0.05)
    vim.api.nvim_exec2(string.format(":res -%.2f", lines), {})
end, { desc = "Decrease height" })

vim.keymap.set("n", "<C-Left>", function ()
    local lines = math.ceil(vim.o.columns * 0.05)
    vim.api.nvim_exec2(string.format(":vert res -%.2f", lines), {})
end, { desc = "Decrease width" })

vim.keymap.set("n", "<C-Right>", function ()
    local lines = math.ceil(vim.o.columns * 0.05)
    vim.api.nvim_exec2(string.format(":vert res +%.2f", lines), {})
end, { desc = "Increase width" })

---------------------------------------- Insert Mode ----------------------------------------

-- Paste while in insert mode
vim.keymap.set("i", "<C-v>", "<Esc>\"+pa", { desc = "Paste while in insert mode" })

---------------------------------------- Visual Mode ----------------------------------------

-- Move text up and down
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv", { desc = "Move lines down one line" })
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv", { desc = "Move lines up one line" })

-- Stay in indent mode
vim.keymap.set("v", "<", "<gv", { desc = "Decrease indent and keep selection" })
vim.keymap.set("v", ">", ">gv", { desc = "Increase indent and keep selection" })

-- Use silicon to create image in CODE_IMAGE_PATH
vim.keymap.set('v', '<leader>sf',  function() require("nvim-silicon").file() end )
-- Use silicon to create image in clipboard
vim.keymap.set('v', '<leader>sc', function() require("nvim-silicon").clip() end )

---------------------------------------- Terminal Mode ----------------------------------------

