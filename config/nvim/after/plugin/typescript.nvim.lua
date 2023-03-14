local lsp = require("lsp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
capabilities["textDocument"]["formatting"] = false

require("typescript").setup({
	server = {
		on_attach = lsp.on_attach_buffer,
		capabilities = capabilities,
	},
})
