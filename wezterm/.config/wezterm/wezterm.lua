-- https://github.com/elijahmanor/dotfiles/blob/master/wezterm/.config/wezterm/wezterm.lua
-- https://github.com/folke/dot/blob/master/config/wezterm/wezterm.lua

local wezterm = require("wezterm")

return {
	window_decorations = "RESIZE",
	color_scheme = "Catppuccin Frappe",
	font = wezterm.font_with_fallback({
		{ family =  "Cascadia Code", harfbuzz_features = { 'ss01=1', 'ss02=1', 'ss19=1', 'ss20=1'}, },
		{ family = "Symbols Nerd Font Mono", scale = 0.75 },
	}),
	window_background_opacity = 1.0,
	adjust_window_size_when_changing_font_size = false,
	use_cap_height_to_scale_fallback_fonts = true,
	font_size = 10,
	scrollback_lines = 10000,
	hide_tab_bar_if_only_one_tab = true,

   window_padding = {
    left = 1,
    right = 1,
    top = 1,
    bottom = 1,
  },
}
