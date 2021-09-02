local utils = require("rockerboo.utils")
local mappings = {}

mappings.setup = function()
	local n = "n"

	local builtin = "<cmd>lua R'telescope.builtin'."

	local maps = {
		{ n, "<Leader>en", builtin .. "find_files{ cwd = '~/.config/nvim' }<cr>" },
		{ n, "<Leader>f", "<cmd>lua R('plugin.telescope').find_files()<cr>" },
		{ n, "<Leader>gf", builtin .. "git_files({ theme = 'dropdown' })<cr>" },
		{ n, "gW", builtin .. "lsp_workspace_symbols(R'telescope.themes'.get_dropdown())<cr>" },
		{ n, "ggr", builtin .. "lsp_workspace_symbols()<cr>" },
		-- {n, "<Leader>gl", builtin .. "live_grep"},
		{
			n,
			"<Leader>gp",
			builtin .. string.format("find_files{ cwd = '%s' }", vim.fn.stdpath("cache")) .. "<cr>",
		},
		{ n, "<Leader>cs", builtin .. "colorscheme({ theme = 'dropdown', enable_preview = true })<cr>" },
	}

	utils.keymaps(maps)
end


return mappings
