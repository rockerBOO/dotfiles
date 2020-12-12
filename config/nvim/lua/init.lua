require "plugin.completion"

require"lsp_config".setup()
require "plugin.treesitter"
require "plugin.telescope"
require "plugin.colorizer"
require "plugin.expressline"

local keymap = function(mode, key, map, opts)
  opts = opts or {}

  vim.api.nvim_set_keymap(mode, key, ":lua " .. map .. "<CR>", opts)
end

keymap("n", "<leader>t",
       "require('plenary.test_harness').test_directory(vim.fn.expand('%:p'),false,{ winopts = {topleft = '┌',topright = '┐',top = '-',left = '|',right = '|',botleft = '└',botright = '┘',bot = '─'}})")

