require"nvim-treesitter.configs".setup {
  -- Modules and its options go here
  highlight = {enable = true},
  incremental_selection = {enable = true},
  textobjects = {enable = true},
  playground = {enable = true, disable = {}, updatetime = 25, persist_queries = false},
}

local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
parser_config.gleam = {
  install_info = {
    url = "~/code/tree-sitter-gleam", -- local path or git repo
    files = {"src/parser.c"}
  },
  filetype = "gleam", -- if filetype does not agrees with parser name
  used_by = {} -- additional filetypes that use this parser
}
