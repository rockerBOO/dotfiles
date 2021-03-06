local telescope = require("telescope")
local themes = require("telescope.themes")
-- local previewers = require("telescope.previewers")
local sorters = require("telescope.sorters")
local utils = require("rockerboo.utils")

local plugins_directory = function()
	return require("packer.util").join_paths(vim.fn.stdpath("data"), "site", "pack")
end

local tele = {}

-- Telescope defaults
tele.setup_defaults = function()
	local telescope_config = {
		selection_strategy = "reset",
		shorten_path = true,
		layout_strategy = "flex",
		layout_config = { prompt_position = "top", width = 0.8, height = 0.7 },
		sorting_strategy = "ascending",
		winblend = 3,
		prompt_prefix = "> ",
		-- generic_sorter = sorters.get_fzy_sorter,
		-- file_sorter = sorters.get_fzy_sorter,
	}

	telescope.setup({ defaults = telescope_config })

	telescope.load_extension("fzf")

	utils.keymap({ "n", "<Leader>gt", "<cmd>lua require'plugin.telescope'.treesitter()<cr>" })
	utils.keymap({ "n", "<Leader>pl", "<cmd>lua require'plugin.telescope'.find_files_plugins()<cr>" })
end

-- Themes
-- >>- ------- -<

local theme = themes.get_dropdown({ winblend = 10, layout_config = { height = 10 } })

tele.theme = function(opts)
	return vim.tbl_deep_extend("force", theme, opts or {})
end

-- File Functions
-- >>- ------- -<

tele.find_files = function(input_opts)
	require("telescope.builtin").find_files(tele.theme(input_opts))
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
end

return tele
