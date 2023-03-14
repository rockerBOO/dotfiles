local utils = require("rockerboo.utils")
local mappings = {}

mappings.setup = function()
	local n = "n"

	local maps = {
		{
			n,
			"<Leader>en",
			function()
				require("telescope.builtin").find_files({
					cwd = "~/.config/nvim",
				})
			end,
		},
		{
			n,
			"<Leader>gp",
			function()
				require("telescope.builtin").live_grep({
					cwd = "~/.config/nvim",
				})
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
			{ silent = true },
		},
		{
			n,
			"<Leader>gd",
			function()
				require("telescope.builtin").lsp_dynamic_workspace_symbols({
					theme = "dropdown",
				})
			end,
		},
		{
			n,
			"<Leader>dd",
			function()
				require("telescope.builtin").diagnostics({
					theme = "dropdown",
				})
			end,
		},
		{
			n,
			"<Leader>ds",
			function()
				require("telescope.builtin").lsp_document_symbols({
					theme = "dropdown",
				})
			end,
		},
		{
			n,
			"gW",
			function()
				require("telescope.builtin").lsp_workspace_symbols(
					require("telescope.themes").get_dropdown()
				)
			end,
		},
		{
			n,
			"ggr",
			require("telescope.builtin").lsp_workspace_symbols,
		},
		-- {n, "<Leader>gl", builtin .. "live_grep"},
		-- {
		-- 	n,
		-- 	"<Leader>gp",
		-- 	function()
		-- 		require("telescope.builtin")(
		-- 			string.format(
		-- 				"find_files{ cwd = '%s' }",
		-- 				vim.fn.stdpath("cache")
		-- 			)
		-- 		)
		-- 	end,
		-- },
		{
			n,
			"<Leader>cs",
			function()
				require("telescope.builtin").colorscheme({
					theme = "dropdown",
					enable_preview = true,
				})
			end,
		},

		-- help
		{ n, "<leader>hh", require("telescope.builtin").help_tags },

		{
			n,
			"z=",
			function()
				require("telescope.builtin").spell_suggest(require(
					"telescope.themes"
				).get_dropdown({
					layout_config = {
						prompt_position = "top",
						width = 50,
						height = 0.7,
					},
				}))
			end,
		},
	}

	utils.keymaps(maps)
end

return mappings
