-- Telescope defaults
local telescope_config = {
  selection_strategy = "reset",
  shorten_path = true,
  layout_strategy = "flex",
  prompt_position = "top",
  sorting_strategy = "ascending",
  preview_cutoff = 1,
  winblend = 3,
}

require"telescope".setup(telescope_config)

function FindFiles()
  require"telescope.builtin".find_files(telescope_config)
end

function LspWorkspaceSymbols()
  require"telescope.builtin".lsp_workspace_symbols()
end

function LiveGrep()
  require"telescope.builtin".live_grep()
end

