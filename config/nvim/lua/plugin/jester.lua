return {
	yarn_debug = function()
		require("jester").debug({ yarn = true, path_to_jest = "jest" })
	end,

	yarn_debug_file = function()
		require("jester").debug_file({ yarn = true, path_to_jest = "jest" })
	end,

	yarn_debug_last = function()
		require("jester").debug_last({ yarn = true, path_to_jest = "jest" })
	end,

	yarn_test = function()
		require("jester").run({
			yarn = true,
			cmd = "yarn run jest -t '$result' -- $file",
		})
	end,

	yarn_test_file = function()
		require("jester").run_file({ yarn = true, cmd = "yarn run jest -- $file" })
	end,

	yarn_test_last = function()
		require("jester").run_last({
			yarn = true,
			cmd = "yarn run jest -t '$result' -- $file",
		})
	end,
}
