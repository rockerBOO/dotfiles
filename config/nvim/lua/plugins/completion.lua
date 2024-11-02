return {
	{
		"hrsh7th/nvim-cmp",
		dependencies = {
			-- "hrsh7th/cmp-buffer",
			"hrsh7th/cmp-nvim-lsp",
			{
				"hrsh7th/cmp-nvim-lua",
				ft = "lua",
				-- this is after/plugin content
				config = function()
					require("cmp").register_source(
						"nvim_lua",
						require("cmp_nvim_lua").new()
					)
				end,
			},
			{
				"L3MON4D3/LuaSnip",
				wants = "rafamadriz/friendly-snippets",
			},
			"hrsh7th/cmp-vsnip",
			"saadparwaiz1/cmp_luasnip",
			"ray-x/cmp-treesitter",
		},
	},
	{
		"petertriho/cmp-git",
		dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
	},

	"hrsh7th/cmp-nvim-lua",
}
