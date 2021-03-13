require("plugin.completion")

require("lsp_config").setup()
require("plugin.treesitter")
require("plugin.telescope").setup_defaults()
require("plugin.colorizer")
require("plugin.expressline")
require("rockerboo.tests").setup()
require("nvim-ts-autotag").setup()
