local OPTIONS = {
    backup         = false,                              -- Don't create backups
    clipboard      = "unnamedplus",                      -- Allows Neovim to access the system clipboard
    completeopt    = "menu,menuone,noselect",
    cursorline     = true,                               -- Highlight the current line
    expandtab      = true,                               -- Expand tabs to spaces
    fileencoding   = "utf-8",                            -- Set file encoding to UTF-8
    foldcolumn     = "4",
    foldexpr       = "v:lua.vim.treesitter.foldexpr()",
    foldlevel      = 99,
    foldlevelstart = -1,
    foldmethod     = "expr",
    foldnestmax    = 4,
    number         = true,                               -- Show line numbers
    relativenumber = true,                               -- Show relative line numbers
    signcolumn     = "auto:2",
    shiftwidth     = 4,                                  -- The number of spaces inserted for indent
    swapfile       = false,                              -- Don't use swapfiles
    tabstop        = 4,                                  -- Insert 4 spaces for tab
    termguicolors  = true,                               -- Use terminal GUI colors
    undodir        = vim.fn.stdpath("data") .. "/undo",  -- Undo file location
    undofile       = true,                               -- Persist undo
}

for k, v in pairs(OPTIONS) do
    vim.opt[k] = v
end

