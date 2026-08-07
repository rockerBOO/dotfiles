return {
	setup = function()
		local stylelint = require("plugin.lint.stylelint")
		local lint = require("lint")
		lint.linters.stylelint = stylelint

		lint.linters_by_ft = {
			-- markdown = { "vale" },
			elixir = { "credo" },
			-- python = { "ruff", "flake8" },
			-- gdscript = { "gdlint" },
			css = { "stylelint" },
      go = { "golangcilint" },
      -- yaml = { "shellcheck" },
		}

		-- "InsertLeave"
		vim.api.nvim_create_autocmd({ "BufWritePost" }, {
			callback = function()
				lint.try_lint()
			end,
		})
	end,
}
