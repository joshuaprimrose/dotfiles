-- :help options

local options = {
    backspace      = "indent,eol,start",                   -- 
    clipboard      = "unnamedplus",		                   -- Allows Neovim to access the system clipboard
    cmdheight      = 2,                                    -- More space in the command area
    colorcolumn    = "120",                                -- Show ruler at column
    completeopt    = "menuone,noselect",                   -- Autocomplete options
    conceallevel   = 0,                                    -- So `` is visible in Markdown files
    cursorline     = true,                                 -- Highlight the current line
    expandtab      = true,                                 -- Expand tabs to spaces
    fileencoding   = "utf-8",                              -- Set file encoding to UTF-8
    foldcolumn     = "1",                                  -- Set to display 1 column 
    foldenable     = true,                                 -- Allow code folding
    foldlevel      = 99,                                   -- Allow deep levels
    foldlevelstart = 99,                                   -- Open new buffers with code fully expanded
    ignorecase     = true,                                 -- ignore case when searching
    mouse          = "a",                                  -- Allow the mouse to be used in Neovim
    number         = true,                                 -- Show line numbers
    numberwidth    = 4,                                    -- Set number column 4 chars wide
    relativenumber = true,                                 -- Show relative line numbers
    scrolloff      = 8,                                    -- Minimum number of lines above and below cursor 
    signcolumn     = "yes",                                -- Always show the sign column
    shiftwidth     = 4,                                    -- The number of spaces inserted for indent
    smartcase      = true,                                 -- If you include mixed case in your search, assumes you want case-sensitive
    smartindent    = true,                                 -- Make indenting smarter
    splitbelow     = true,                                 -- Force all horizontal splits to go below
    splitright     = true,                                 -- Force all vertical splits to go to the right
    swapfile       = false,                                -- Don't create a swapfile
    tabstop        = 4,                                    -- Insert 4 spaces for tab
    termguicolors  = true,                                 -- Use terminal GUI colors
    timeoutlen     = 1000,                                 -- Time in ms to wait for a sequence to complete
    undodir        = "/undo",                              -- Undo file location
    undofile       = true,                                 -- Persist undo
    updatetime     = 500,                                  -- Faster completeion (default is 4000 ms)
    wrap           = false                                 -- Do not wrap lines
}

for k, v in pairs(options) do
        vim.opt[k] = v
end

