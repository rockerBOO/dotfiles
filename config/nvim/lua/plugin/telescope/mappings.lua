local utils = require("rockerboo.utils")
local mappings = {}

mappings.setup = function()
	local n = "n"

	local maps = {
		{
			n,
			"<Leader>en",
			function()
				require("telescope.builtin").find_files({ cwd = "/home/rockerboo/.config/nvim" })
			end,
		},
		{
			n,
			"<Leader>f",
			require("plugin.telescope").find_files,
		},
		{
			n,
			"<Leader>gf",
			function()
				require("telescope.builtin").git_files({ theme = "dropdown" })
			end,
		},
		{
			n,
			"gW",
			function()
				require("telescope.builtin").lsp_workspace_symbols(require("telescope.themes").get_dropdown())
			end,
		},
		{
			n,
			"ggr",
			require("telescope.builtin").lsp_workspace_symbols,
		},
		-- {n, "<Leader>gl", builtin .. "live_grep"},
		{
			n,
			"<Leader>gp",
			function()
				require("telescope.builtin")(string.format(
					"find_files{ cwd = '%s' }",
					vim.fn.stdpath("cache")
				))
			end,
		},
		{
			n,
			"<Leader>cs",
			function()
				require("telescope.builtin").colorscheme({ theme = "dropdown", enable_preview = true })
			end,
		},
	}

	utils.keymaps(maps)
end

return mappings
