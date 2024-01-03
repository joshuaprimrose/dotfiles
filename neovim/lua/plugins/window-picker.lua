return {
    {
        's1n7ax/nvim-window-picker',
        config = function()
            require'window-picker'.setup({
                hint = "floating-big-letter",
            })
        end,
        event = 'VeryLazy',
        name = 'window-picker',
        version = '2.*',
    }
}

