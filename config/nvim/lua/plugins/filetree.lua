return {
	{
		"kyazdani42/nvim-tree.lua",
		dependencies = {
			-- "kyazdani42/nvim-web-devicons", -- optional, for file icons
			"nvim-tree/nvim-web-devicons",
		},
		config = function()
			require("nvim-tree").setup()
		end,
	},
}
