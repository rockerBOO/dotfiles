-- Configure the completion chains for completion.nvim
vim.g.completion_chain_complete_list = {
  default = {
    default = {
      {complete_items = {"lsp", "snippet"}},
      {complete_items = {"buffer"}},
    },
    typescript = { 
      {complete_items = {'lsp', 'snippet', 'ts'}},
      {complete_items = {"buffer"}}
    }
  },
}

vim.g.completion_matching_strategy_list = {"fuzzy", "exact", "substring", "all"}


