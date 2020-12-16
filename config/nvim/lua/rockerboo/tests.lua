-- [[
-- Configuration for running the plenary test harness
-- ]]
local test_runner = {}

local keymap = function(mode, key, map, opts)
  opts = opts or {}

  vim.api.nvim_set_keymap(mode, key, ":lua " .. map .. "<CR>", opts)
end

test_runner.setup = function()
  keymap("n", "<leader>t", "require('rockerboo.tests').run(vim.fn.expand('%:p'))")
end

test_runner.run = function(file_or_directory)
  local opts = {
    winopts = {
      topleft = "┌",
      topright = "┐",
      top = "-",
      left = "|",
      right = "|",
      botleft = "└",
      botright = "┘",
      bot = "─",
    },
  }
  return require"plenary.test_harness".test_directory(file_or_directory, opts)
end

return test_runner
