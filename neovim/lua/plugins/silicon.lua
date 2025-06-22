local code_image_path = os.getenv("CODE_IMAGE_PATH")

return {
	"michaelrommel/nvim-silicon",
	lazy = true,
	cmd = "Silicon",
	opts = {
        background = "#553880",
        gobble = true,
        line_pad = 10,
        no_round_corner = false,
        -- num_separator = "\u{258f} ",
        num_separator = " ",
        -- output = "C:\\Users\\joshua.primrose\\OneDrive - BAE Systems Inc\\Documents\\Images\\Silicon\\$month-$date-$year-$time.png",
        output = function ()
            if not code_image_path or string.len(code_image_path) == 0 then
                print("Will default to current directory unti you set the CODE_IMAGE_PATH environment variable.")

                return vim.fn.expand("%:p:h") .. "\\" .. os.date("%m-%d-%YT%H-%M-%SZ") .. ".png"
            end

            return code_image_path .. "\\" .. os.date("%m-%d-%YT%H-%M-%SZ") .. ".png"
        end,
        pad_horiz = 50,
        pad_vert = 40,
        shadow_color = "#5B4280",
        shadow_blur_radius = 16,
        shadow_offset_x = 8,
        shadow_offset_y = 8,
        -- Need to add https://github.com/catppuccin/bat/blob/main/themes/Catppuccin%20Mocha.tmTheme to AppData\Roaming\silicon\themes
        -- and run silicon --build-cache from the AppData\Roaming\silicon directory
        theme = "Catppuccin Mocha",
        window_title = function ()
            return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(vim.api.nvim_get_current_buf()), ":t")
        end
	},
}

