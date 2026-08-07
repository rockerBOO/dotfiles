return {
	"stevearc/dressing.nvim",
	"nvim-lua/popup.nvim",
	-- "ThePrimeagen/harpoon",

	{
		"folke/trouble.nvim",
		config = function()
			require("trouble").setup({})
		end,
	},

	"MunifTanjim/nui.nvim",
	{
		"j-hui/fidget.nvim",
		tag = "legacy",
		config = function()
			require("fidget").setup({
				sources = { -- Sources to configure
					itex = { -- Name of source
						ignore = true, -- Ignore notifications from this source
					},
				},
				-- fmt = {
				-- 	max_messages = 2,
				-- },
			})
		end,
	},

	-- 2026-04-09 Not working in 0.13
	-- {
	-- 	-- Make sure to setup it properly if you have lazy=true
	-- 	"MeanderingProgrammer/render-markdown.nvim",
	-- 	opts = {
	-- 		file_types = { "markdown", "Avante" },
	-- 		bullet = {
	-- 			-- Turn on / off list bullet rendering
	-- 			enabled = false,
	-- 		},
	-- 	},
	-- 	ft = { "markdown", "Avante" },
	-- },

	{
		dir = "~/code/others/player.nvim",
		cmd = "Player",
		config = function()
			require("player").setup()
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			require("notify").setup({
				render = "minimal",
				timeout = 3000,
				background_colour = "#000000",
			})
			vim.notify = require("notify")
		end,
	},

	{ "jake-stewart/force-cul.nvim" },
	{
		"mcauley-penney/visual-whitespace.nvim",
		config = true,
		keys = { "v", "V", "<C-v>" }, -- optionally, lazy load on visual mode keys
	},
}
