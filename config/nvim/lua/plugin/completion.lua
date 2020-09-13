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
