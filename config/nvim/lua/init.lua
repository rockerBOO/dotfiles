require("lsp_config")
require("plugin.completion")
require("plugin.treesitter")
require("plugin.telescope")

-- neovim lua lsp 
require("nlua.lsp.nvim").setup(nvim_lsp, {on_attach = on_attach_vim})

-- Express Line 
require"el".setup {}


