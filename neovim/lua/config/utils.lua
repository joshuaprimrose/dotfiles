local keymap = function (mode, keys, func, opts)
    local options = { noremap = true, silent = true }

    if opts then
        options = vim.tbl_extend("force", options, opts)
    end

    vim.keymap.set(mode, keys, func, options)
end

-- Need to cache the results of git rev-parse because process is expensive in Windows
local is_inside_work_tree = {}

local call_git_files = function ()
    local cwd = vim.fn.getcwd()

    if is_inside_work_tree[cwd] == nil then
        vim.fn.system("git rev-parse --is_inside_work_tree")
        is_inside_work_tree[cwd] = vim.v.shell_error == 0
    end

    if is_inside_work_tree[cwd] then
        return true
    else
        return false
    end
end

return {
    call_git_files = call_git_files,
    keymap = keymap,
}

