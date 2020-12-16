local telescope = require "telescope"
local themes = require "telescope.themes"
local previewers = require "telescope.previewers"

local tele = {}

-- Telescope defaults
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

function tele.find_files()
  local theme = themes.get_dropdown {winblend = 10, results_height = 10}
  require"telescope.builtin".find_files(theme)
end

return tele

