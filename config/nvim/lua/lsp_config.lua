-- local lsp_status = require("lsp-status")
-- lsp_status.register_progress()
-- lsp_status.config {kind_labels = vim.g.completion_customize_lsp_label}
-- local status = require("rockerboo.lsp_status")
local nvim_lsp = require("nvim_lsp")

-- config.capabilities = vim.tbl_extend('keep', default_lsp_config.capabilities or {}, lsp_status.capabilities)
-- not sure what config is to extend this in lsp-status

--- Language servers
local on_attach_vim = function(client)

  require"completion".on_attach(client)
  require"diagnostic".on_attach(client)
  -- status.on_attach(client)
end


local default_lsp_config = {on_attach = on_attach_vim}

nvim_lsp.elixirls.setup(default_lsp_config)
nvim_lsp.rust_analyzer.setup(default_lsp_config)
nvim_lsp.tsserver.setup(default_lsp_config)
nvim_lsp.pyls.setup(default_lsp_config)
nvim_lsp.gopls.setup(default_lsp_config)
nvim_lsp.cssls.setup(default_lsp_config)
nvim_lsp.vimls.setup(default_lsp_config)
nvim_lsp.bashls.setup(default_lsp_config)

-- nlua.lsp uses sumneko_lua
-- nvim_lsp.sumneko_lua.setup(default_lsp_config)
-- neovim lua lsp
require("nlua.lsp.nvim").setup(nvim_lsp, {on_attach = on_attach_vim})

