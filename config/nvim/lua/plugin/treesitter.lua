require"nvim-treesitter.configs".setup {
  -- Modules and its options go here
  highlight = {enable = true},
  incremental_selection = {enable = true},
  textobjects = {enable = true},
  playground = {enable = true, disable = {}, updatetime = 25, persist_queries = false},
}
