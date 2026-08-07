return {
	on_attach = function()
		-- If you're using Ruff alongside another language server (like Pyright),
		-- you may want to defer to that language server for certain capabilities,
		-- like textDocument/hover:
		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup(
				"lsp_attach_disable_ruff_hover",
				{ clear = true }
			),
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if client == nil then
					return
				end
				if client.name == "ruff" then
					-- Disable hover in favor of Pyright
					client.server_capabilities.hoverProvider = false
				end
			end,
			desc = "LSP: Disable hover capability from Ruff",
		})
	end,
	filetypes = { "python" },
	cmd = { "ruff", "server" },
	root_markers = { "pyproject.toml", "ruff.toml", ".ruff.toml" },
	-- trace = "messages",
	settings = {
		ruff = {
			fixAll = false,
			organizeImports = false,
		},
	},
}
