return {
	yarn_debug = function()
		require("jester").debug({
			-- path_to_jest_debug = "yarn jest",
			-- dap = {
			-- 	type = "yarn",
			-- 	outdir = "${workspaceroot}",
			-- 	runtiumeExecutable = "yarn",
			-- 	runtimeArgs = {
			-- 		"run",
			-- 		"--inspect",
			-- 		"--inspect-brk",
			-- 		"jest",
			-- 		"--no-coverage",
			-- 		"-t",
			-- 		"$result",
			-- 		"--",
			-- 		"$file",
			-- 	},
			-- },
		})
		-- require("jester").debug()
		--
		-- require("jester").debug({
		-- 	dap = {
		-- type = "yarn",
		-- 		runtimeArgs = {
		-- 			"run",
		-- 			"--inspect",
		-- 			"--inspect-brk",
		-- 			"jest",
		-- 			"--no-coverage",
		-- 			"-t",
		-- 			"$result",
		-- 			"--",
		-- 			"$file",
		-- 		},
		-- 	},
		-- })
	end,

	yarn_debug_file = function()
		-- require("jester").debug_file({ yarn = true, path_to_jest = "jest" })
		-- require("jester").debug_file()
		require("jester").debug_file()
		-- 		require("jester").debug_file({
		-- 			dap = {
		--         type = "yarn",
		-- 				runtimeArgs = {
		-- 					-- "yarn",
		-- 					"run",
		-- 					"--inspect",
		-- 					"--inspect-brk",
		-- 					"jest",
		-- 					"--no-coverage",
		-- 					"-t",
		-- 					"$result",
		-- 					"--",
		-- 					"$file",
		-- 				},
		-- 			},
		-- 		})
	end,

	yarn_debug_last = function()
		-- require("jester").debug_last({ yarn = true, path_to_jest = "jest" })
		require("jester").debug_last()
	end,

	yarn_test = function()
		-- require("jester").run()
		require("jester").run({
			-- 	 yarn = true,
			cmd = "yarn run jest -t '$result' -- $file",
		})
	end,

	yarn_test_file = function()
		require("jester").run_file()
		-- require("jester").run_file({
		--  yarn = true,
		--  cmd = "yarn run jest -- $file",
		--  })
	end,

	yarn_test_last = function()
		-- require("jester").run_last()
		require("jester").run_last({
			yarn = true,
			cmd = "yarn run jest -t '$result' -- $file",
		})
	end,

	setup = function()
		require("jester").setup({
			-- dap = {
			-- 	type = "yarn",
			-- 	outDir = "${workspaceRoot}",
			-- },
		})
	end,

	mappings = function()
		local n = "n"
		local keymaps = {
			{ n, "<Leader>dt", require("plugin.jester").yarn_debug },
			{ n, "<Leader>df", require("plugin.jester").yarn_debug_file },
			{ n, "<Leader>dl", require("plugin.jester").yarn_debug_last },

			{ n, "<Leader>tt", require("plugin.jester").yarn_test },
			{ n, "<Leader>tf", require("plugin.jester").yarn_test_file },
			-- j n, "<Leader>tl", require("plugin.jester").yarn_test_last },
			{
				n,
				"<Leader>tl",
				function()
					require("jester").run_last()
				end,
			},
		}

		for _, keymap in ipairs(keymaps) do
			vim.keymap.set(keymap[1], keymap[2], keymap[3], { buffer = true })
		end
	end,
}
