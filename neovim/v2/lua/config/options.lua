-- See https://neovim.io/doc/user/quickref.html#option-list

local OPTIONS = {
    -- Basic
    cursorline     = true,                               -- Highlight the current line
    number         = true,                               -- Show line numbers
    relativenumber = true,                               -- Show relative line numbers
    scrolloff      = 15,                                 -- Minimum number of lines above and below the cursor
    sidescrolloff  = 25,                                 -- Minimum number of columns to left and right of cursor
    wrap           = false,                              -- Don't wrap lines

    -- Clipboard
    clipboard      = "unnamedplus",                      -- Allows Neovim to access the system clipboard

    -- Cursor
    guicursor      = "n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor,sm:block-blinkwait175-blinkoff150-blinkon175",

    -- File Handling
    backup         = false,                              -- Don't create backups
    fileencoding   = "utf-8",                            -- Set file encoding to UTF-8
    swapfile       = false,                              -- Don't use swapfiles
    undodir        = vim.fn.stdpath("data") .. "/undo",  -- Undo file location
    undofile       = true,                               -- Persist undo

    -- Folding
    foldcolumn     = "4",                                -- Width of the column used to indicate folds
    foldexpr       = "v:lua.vim.treesitter.foldexpr()",  -- Expression used when 'foldmethod' is "expr"
    foldlevel      = 99,                                 -- Close folds with a level higher than this
    foldlevelstart = -1,                                 -- 'foldlevel' when starting to edit a file
    foldmethod     = "expr",                             -- Folding type
    foldnestmax    = 4,                                  -- Maximum fold depth

    -- Indentation
    autoindent     = false,                              -- Take indent for new line from previous line
    breakindent    = true,                               -- Wrapped line repeats indent
    expandtab      = true,                               -- Expand tabs to spaces
    shiftwidth     = 4,                                  -- The number of spaces inserted for indent
    smartindent    = false,                              -- Smart autoindenting for C programs
    softtabstop    = 4,                                  -- Number of columns between two soft tab stops
    tabstop        = 4,                                  -- Insert 4 spaces for tab

    -- Other
    completeopt    = "menu,menuone,noselect",            -- Options for Insert mode completion
    confirm        = true,                               -- Ask what to do about unsaved/read-only files
    mouse          = "a",                                -- Enable the use of mouse clicks

    -- Performance
    updatetime     = 250,                                -- After this many milliseconds flush swap file

    -- Search
    hlsearch       = true,                               -- Highlight matches with last search pattern
    incsearch      = true,                               -- Highlight match while typing search pattern
    ignorecase     = true,                               -- Ignore case in search patterns
    smartcase      = true,                               -- No ignore case when pattern has uppercase

    -- Visual
    colorcolumn    = "120",                              -- Columns to highlight
    showmode       = false,                              -- Message on status line to show current mode
    signcolumn     = "auto:9",                           -- When and how to display the sign column
    termguicolors  = true,                               -- Use terminal GUI colors

}

for k, v in pairs(OPTIONS) do
    vim.opt[k] = v
end
