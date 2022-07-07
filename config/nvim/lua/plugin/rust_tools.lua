local lsp = require("lsp")
local capabilities = require("cmp_nvim_lsp").update_capabilities(
	vim.lsp.protocol.make_client_capabilities()
)
return {
	setup = function()
		require("rust-tools").setup({
			tools = {
				autoSetHints = false,
				hover_with_actions = true,
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
						diagnostics = {
							experimental = true,
						},
					},
				},
			},
		})

		vim.keymap.set(
			"n",
			"<Leader>tl",
			require("rust-tools.utils.cache").execute_last_runnable
		)
	end,
}
