local lsp = require("rockerboo.lsp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

require("rust-tools").setup({
	tools = {
		hover_actions = { border = false },
		cache = true,
	},
	server = {
		on_attach = lsp.on_attach_buffer,
		capabilities = capabilities,
		cmd = {
			"rustup",
			"run",
			"nightly",
			"rust-analyzer",
		},
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = "clippy",
				},
				-- diagnostics = {
				-- 	experimental = true,
				-- },
			},
		},
	},
})

if require("rust-tools.runnables").execute_last_runnable then
	vim.keymap.set(
		"n",
		"<Leader>tl",
		require("rust-tools.runnables").execute_last_runnable
	)
end
