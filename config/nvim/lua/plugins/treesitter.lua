return {
	{
		"nvim-treesitter/nvim-treesitter",
		build = function()
			require("nvim-treesitter.install").update({ with_sync = true })()
		end,
	},
	{
		"windwp/nvim-ts-autotag",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"RRethy/nvim-treesitter-textsubjects",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"mfussenegger/nvim-ts-hint-textobject",
		config = function()
			require("tsht").config.hint_keys = {
				"h",
				"j",
				"f",
				"d",
				"n",
				"v",
				"s",
				"l",
				"a",
			}
		end,

		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},
	{
		"theHamsta/nvim-semantic-tokens",
		config = function()
			require("nvim-semantic-tokens").setup({
				preset = "default",
				highlighters = {
					require("nvim-semantic-tokens.table-highlighter"),
				},
			})
		end,
		ependencies = { "nvim-treesitter/nvim-treesitter" },
	},
}
