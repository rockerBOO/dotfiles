local nvim_status  = require('lsp-status')

local status = {}

status.select_symbol = function(cursor_pos, symbol)
  if symbol.valueRange then
    local value_range = {
      ["start"] = {
        character = 0,
        line = vim.fn.byte2line(symbol.valueRange[1])
      },
      ["end"] = {
        character = 0,
        line = vim.fn.byte2line(symbol.valueRange[2])
      }
    }

    return require("lsp-status.util").in_range(cursor_pos, value_range)
  end
end

status.activate = function()
  nvim_status.onfig {
    select_symbol = status.select_symbol
  }

  nvim_status.register_progress()
end

status.on_attach = function(client)
  nvim_status.on_attach(client)

  vim.cmd [[augroup boo_lsp_status]]
  vim.cmd [[  autocmd CursorHold,BufEnter <buffer> lua require('lsp-status').update_current_function()]]
  vim.cmd [[augroup END]]
end

return status

