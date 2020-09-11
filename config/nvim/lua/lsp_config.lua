local lsp_status = require("lsp-status")

lsp_status.register_progress()
lsp_status.config {kind_labels = vim.g.completion_customize_lsp_label}
local status = require("rockerboo.lsp_status")
local nvim_lsp = require("nvim_lsp")

local on_attach_vim = function(client)
  require"completion".on_attach(client)
  require"diagnostic".on_attach(client)
  status.on_attach(client)
end

local default_lsp_config = {capabilities = lsp_status.capabilities, on_attach = on_attach_vim}

require"el".setup {}

-- config.capabilities = vim.tbl_extend('keep', default_lsp_config.capabilities or {}, lsp_status.capabilities)
-- Configure the completion chains for completion.nvim
vim.g.completion_chain_complete_list = {
  default = {
    default = {
      {complete_items = {"lsp", "snippet"}},
      {complete_items = {"buffer"}},
      {mode = "file"},
    },
  },
}

--- Language servers
nvim_lsp.elixirls.setup(default_lsp_config)
nvim_lsp.rust_analyzer.setup(default_lsp_config)
nvim_lsp.tsserver.setup(default_lsp_config)
nvim_lsp.pyls.setup(default_lsp_config)
nvim_lsp.gopls.setup(default_lsp_config)
nvim_lsp.cssls.setup(default_lsp_config)
nvim_lsp.vimls.setup(default_lsp_config)
nvim_lsp.bashls.setup(default_lsp_config)
nvim_lsp.sumneko_lua.setup(default_lsp_config)

-- Pack on neovim lua functionality
require("nlua.lsp.nvim").setup(nvim_lsp, {on_attach = on_attach_vim})

require"nvim-treesitter.configs".setup {
  -- Modules and its options go here
  highlight = {enable = true},
  incremental_selection = {enable = true},
  textobjects = {enable = true},
}

local telescope_config = {
  selection_strategy = "reset",
  shorten_path = true,
  layout_strategy = "flex",
	prompt_position = "top",
	sorting_strategy = "ascending"
}

local function join(t1, t2)
  for k, v in ipairs(t2) do table.insert(t1, v) end
  return t1
end

function GitFiles()
  require"telescope.builtin".git_files(telescope_config)
end

function LspWorkspaceSymbols()
  require"telescope.builtin".lsp_workspace_symbols(telescope_config)
end

function LiveGrep()
  require"telescope.builtin".live_grep(telescope_config)
end
