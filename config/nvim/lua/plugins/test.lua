return {
	{
		"David-Kunz/jester",
		config = function()
			require("jester").setup({
				dap = {
					type = "yarn",
				},
				path_to_jest_debug = "test",
				path_to_jest_run = "test",
				-- cmd = "test -t '$result' -- $file", -- run command
			})
		end,
	},
}
