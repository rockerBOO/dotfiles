-- local telescope = require "telescope"
local themes = require "telescope.themes"
-- Telescope defaults
-- local config = {
--   selection_strategy = "reset",
--   shorten_path = true,
--   layout_strategy = "flex",
--   prompt_position = "top",
--   sorting_strategy = "ascending",
--   preview_cutoff = 1,
--   winblend = 3,
-- }

-- telescope.setup(config)


function FindFiles()
  local theme = themes.get_dropdown{ winblend = 10 }
  require"telescope.builtin".find_files(theme)


  -- require"telescope.builtin".find_files {
  --   sorting_strategy = "ascending",
  --   preview_cutoff = 200,
  --   layout_strategy = "center",
  --   winblend = 3,
  -- }
end
