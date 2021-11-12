local telescope = require("telescope")
local themes = require("telescope.themes")
local utils = require("rockerboo.utils")

local plugins_directory = function()
	return require("packer.util").join_paths(vim.fn.stdpath("data"), "site", "pack")
end

local tele = {}

-- Telescope defaults
tele.setup_defaults = function()
	local telescope_config = {
		selection_strategy = "reset",
		layout_strategy = "flex",
		layout_config = { prompt_position = "top", width = 0.8, height = 0.7 },
		sorting_strategy = "ascending",
		winblend = 3,
		prompt_prefix = "> ",
	}

	telescope.setup({ defaults = telescope_config })

	-- fzf native
	telescope.load_extension("fzf")

	utils.keymap({
		"n",
		"<Leader>ca",
		"<cmd>lua require('telescope.builtin').lsp_code_actions(require('telescope.themes').get_cursor())<CR>",
	})
	utils.keymap({ "n", "<Leader>gt", "<cmd>lua require'plugin.telescope'.treesitter()<cr>" })
	utils.keymap({ "n", "<Leader>pl", "<cmd>lua require'plugin.telescope'.find_files_plugins()<cr>" })

	require("plugin.telescope.mappings").setup()
end

-- Themes
-- >>- ------- -<

tele.theme = function(opts)
	local theme = themes.get_dropdown({ layout_config = { height = 15 } })
	return vim.tbl_deep_extend("force", theme, opts or {})
end

-- File Functions
-- >>- ------- -<

tele.find_files = function(input_opts)
	local options = vim.tbl_deep_extend("force", {
		previewer = false,
		debounce = 30,
	}, input_opts or {})
	require("telescope.builtin").find_files(tele.theme(options))
end

tele.find_files_plugins = function()
	require("telescope.builtin").find_files(tele.theme({ cwd = plugins_directory() }))
end

-- Treesitter
-- >>- ------- -<

tele.treesitter = function()
	return require("telescope.builtin").treesitter(tele.theme())
end

function P(module)
	require("plenary.reload").reload_module(module)
end

function PlenaryReload()
	require("plenary.reload").reload_module("telescope")
	require("plenary.reload").reload_module("plenary")
	require("plenary.reload").reload_module("boo-colorscheme")
	require("plenary.reload").reload_module("plugin")
	require("plenary.reload").reload_module("lsp_extensions")
	require("boo-colorscheme").use()
	tele.setup_defaults()
	require("setup").setup()
end

return tele
