local telescope = require "telescope"
local themes = require "telescope.themes"
local previewers = require "telescope.previewers"

local tele = {}

-- Telescope defaults
tele.setup = function()
  local telescope_config = {
    selection_strategy = "reset",
    shorten_path = true,
    layout_strategy = "flex",
    prompt_position = "top",
    sorting_strategy = "ascending",
    winblend = 3,
    prompt_prefix = "※",
    width = 0.8,
    height = 0.7,
    results_width = 80,
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
  }

  telescope.setup({defaults = telescope_config})
end

function tele.find_files(input_opts)
  local opts = vim.tbl_deep_extend("force",
                                   themes.get_dropdown {winblend = 10, results_height = 10},
                                   input_opts or {})
  require"telescope.builtin".find_files(opts)
end

function tele.find_files_plugins()
  local cwd = require"packer.util".join_paths(vim.fn.stdpath("data"), "site", "pack")

  local opts = themes.get_dropdown {winblend = 10, results_height = 10, cwd = cwd}
  require"telescope.builtin".find_files(opts)
end

return tele
