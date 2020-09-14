local telescope = require"telescope"

-- Telescope defaults
local config = {
  selection_strategy = "reset",
  shorten_path = true,
  layout_strategy = "flex",
  prompt_position = "top",
  sorting_strategy = "ascending",
  preview_cutoff = 1,
  winblend = 3,
}

telescope.setup(config)

