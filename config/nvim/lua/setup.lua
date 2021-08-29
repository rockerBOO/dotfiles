return {
	setup = function()
		require("lsp_config").setup()
		require("plugin.treesitter").setup()
		require("plugin.telescope").setup_defaults()
		require("plugin.colorizer")
		require("plugin.expressline")
		require("rockerboo.tests").setup()
		require("nvim-ts-autotag").setup()

		require("plugin.completion")
		require("plugin.symbols-outline").setup()
	end,
}
