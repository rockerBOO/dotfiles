return {
	-- {
	-- 	"David-Kunz/jester",
	-- 	config = function()
	-- 		require("jester").setup({
	-- 			dap = {
	-- 				type = "yarn",
	-- 			},
	-- 			path_to_jest_debug = "test",
	-- 			path_to_jest_run = "test",
	-- 			-- cmd = "test -t '$result' -- $file", -- run command
	-- 		})
	-- 	end,
	-- },
	{
		"nvim-neotest/neotest",
		dependencies = {
			"nvim-neotest/nvim-nio",
			"nvim-lua/plenary.nvim",
			"antoinemadec/FixCursorHold.nvim",
			"nvim-treesitter/nvim-treesitter",
			"nvim-neotest/neotest-python",
			"marilari88/neotest-vitest",
			"fredrikaverpil/neotest-golang",
		},
		config = function()
			require("neotest").setup({
				adapters = {
					require("neotest-python"),
					require("neotest-vitest")({
						-- Filter directories when searching for test files. Useful in large projects (see Filter directories notes).
						filter_dir = function(name, rel_path, root)
							return name ~= "node_modules"
						end,
					}),
					require("rustaceanvim.neotest"),
					require("neotest-golang"),
				},
			})
		end,
	},
}
