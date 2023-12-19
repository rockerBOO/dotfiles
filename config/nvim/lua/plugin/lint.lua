return {
	setup = function()
		require("lint").linters_by_ft = {
			markdown = { "vale" },
			elixir = { "credo" },
			python = { "ruff", "flake8" },
			-- gdscript = { "gdlint" },
		}

		-- "InsertLeave"
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
