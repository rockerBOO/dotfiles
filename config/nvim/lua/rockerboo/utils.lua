local m = {}

-- @param mode string 'n' | 'i' | 'v'
-- @param lhs string key to map
-- @param rhs string command to run
m.keymap = function(map)
  map = map or {}
  local opts = map[4] or {}
  return vim.api.nvim_set_keymap(map[1], map[2], map[3], opts)
end

m.format = function()
  for _, client in pairs(vim.lsp.buf_get_clients()) do
    print(string.format("Formatting for attached client: %s", client.name))
  end

  vim.lsp.buf.formatting_sync(nil, 1000)
end

return m
