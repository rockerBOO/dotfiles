local utils = require'rockerboo.utils'
local mappings = {}

mappings.setup = function() 
  local n = "n"

  local builtin = "<cmd>lua require'telescope.builtin'."

  local maps = {
    {n, '<Leader>en', builtin .. "find_files{ cwd = '~/.config/nvim'"},
    {n, "<Leader>f",  builtin .. "find_files{}"}, 
    {n, "<Leader>gf", builtin .. "git_files(require'telescope.themes'.get_dropdown())"},
    {n, "<Leader>gg", builtin .. "file_files{cwd = '~/.config/nvim'"},
    {n, "ggr", builtin .. "lsp_workspace_symbols"},
    {n, "<Leader>P",  builtin .. "planets"},
    {n, "<Leader>gl", builtin .. "live_grep"}
  }

  utils.keymaps(maps)
end


function P(module)
  require'plenary.reload'.reload_module(module)
end

function PlenaryReload()
  require('plenary.reload').reload_module("telescope.themes")
  require('plenary.reload').reload_module("telescope")
  require('plenary.reload').reload_module("plenary")
  require'plenary.reload'.reload_module('boo-colorscheme')
  require'plenary.reload'.reload_module('plugin')
  require'plenary.reload'.reload_module('lsp_extensions')
  require'boo-colorscheme'.use{}
end

return mappings
