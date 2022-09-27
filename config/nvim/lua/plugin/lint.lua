return {
	setup = function()
		require("lint").linters_by_ft = {
			markdown = { "vale" },
			elixir = { "credo" },
		}

		vim.api.nvim_create_autocmd({ "BufWritePost", "InsertLeave" }, {
			callback = function()
				require("lint").try_lint()
			end,
		})
	end,
}
