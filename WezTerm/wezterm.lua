local wezterm = require("wezterm")

local act = wezterm.action
-- local mux = wezterm.mux

-- wezterm.on("gui-startup", function()
--     local tab, pane, window = mux.spawn_window()
--     window:gui_window():maximize()
-- end)

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

config.color_scheme = "Tokyo Night"
config.default_cwd = "C:/Dev/repos"
config.default_prog = {
    "C:/Program Files/PowerShell/7/pwsh.exe"
}
config.font = wezterm.font("FantasqueSansM Nerd Font Mono")

config.keys = {
    {
        key = "|",
        mods = "CTRL|SHIFT",
        action = act.PaneSelect({
            mode = "Activate",
        }),
    },
}

config.inactive_pane_hsb = {
    brightness = 0.7,
    saturation = 0.8,
}

config.scrollback_lines = 5000

config.use_dead_keys = false

config.window_background_opacity = 0.92

return config

