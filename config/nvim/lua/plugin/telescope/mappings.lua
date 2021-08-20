local utils = require("rockerboo.utils")
local mappings = {}

mappings.setup = function()
	local n = "n"

	local builtin = "<cmd>lua require'telescope.builtin'."

	local maps = {
		{ n, "<Leader>en", builtin .. "find_files{ cwd = '~/.config/nvim' }<cr>" },
		{ n, "<Leader>f", "<cmd>lua require('plugin.telescope').find_files()<cr>" },
		{ n, "<Leader>gf", builtin .. "git_files({ theme = 'dropdown' })<cr>" },
		{ n, "gW", builtin .. "lsp_workspace_symbols(require'telescope.themes'.get_dropdown())<cr>" },
		{ n, "ggr", builtin .. "lsp_workspace_symbols()<cr>" },
		-- {n, "<Leader>gl", builtin .. "live_grep"},
		{
			n,
			"<Leader>gp",
			builtin .. string.format("find_files{ cwd = '%s' }", vim.fn.stdpath("cache")) .. "<cr>",
		},
    { n, "<Leader>cs", builtin .. "colorscheme({ theme = 'dropdown', enable_preview = true })<cr>" }
	}

	utils.keymaps(maps)
end

function P(module)
	require("plenary.reload").reload_module(module)
end

function PlenaryReload()
	require("plenary.reload").reload_module("telescope.themes")
	require("plenary.reload").reload_module("telescope")
	require("plenary.reload").reload_module("plenary")
	require("plenary.reload").reload_module("boo-colorscheme")
	require("plenary.reload").reload_module("plugin")
	require("plenary.reload").reload_module("lsp_extensions")
	require("plenary.reload").reload_module("plugin")
	require("plenary.reload").reload_module("rockerboo")
	mappings.setup()
	require("boo-colorscheme").use({})
end

return mappings
