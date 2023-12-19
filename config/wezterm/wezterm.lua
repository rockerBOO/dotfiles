local wezterm = require("wezterm")

-- pub struct Palette {
--     /// The text color to use when the attributes are reset to default
--     pub foreground: Option<RgbColor>,
--     /// The background color to use when the attributes are reset to default
--     pub background: Option<RgbColor>,
--     /// The color of the cursor
--     pub cursor_fg: Option<RgbColor>,
--     pub cursor_bg: Option<RgbColor>,
--     pub cursor_border: Option<RgbColor>,
--     /// The color of selected text
--     pub selection_fg: Option<RgbColor>,
--     pub selection_bg: Option<RgbColor>,
--     /// A list of 8 colors corresponding to the basic ANSI palette
--     pub ansi: Option<[RgbColor; 8]>,
--     /// A list of 8 colors corresponding to bright versions of the
--     /// ANSI palette
--     pub brights: Option<[RgbColor; 8]>,
--     /// Configure the colors and styling of the tab bar
--     pub tab_bar: Option<TabBarColors>,
--     /// The color of the "thumb" of the scrollbar; the segment that
--     /// represents the current viewable area
--     pub scrollbar_thumb: Option<RgbColor>,
--     /// The color of the split line between panes
--     pub split: Option<RgbColor>,
-- }

return {
	enable_tab_bar = false,
	font = wezterm.font("JetBrainsMono Nerd Font"),
	font_size = 16.0,
	window_padding = {
		left = 8,
		right = 8,
		top = 8,
		bottom = 8,
	},
	color_scheme = "Cloud",
	color_schemes = {
		["Cloud"] = {
			foreground = "#ffffff",
			background = "#000000",
			ansi = { "#1a1e1d", "#dbabeb", "#9c75dd", "#7fa7af", "#64629f", "#5f4c65", "#a9d1df", "#f0f4ef" },
			brights = { "#5d6f74", "#d95490", "#63b0b0", "#c0c0dd", "#5786bc", "#3f3442", "#849da2", "#f5f4ef" },
		},
	},
}
