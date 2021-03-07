local lsp_status = require("lsp-status")
local status = require("rockerboo.lsp_status")
local utils = require("rockerboo.utils")
local config = require("lspconfig")

local setup = function()
	status.activate()

	--- Language servers
	local on_attach_vim = function(client)
		print("'" .. client.name .. "' language server attached")

		require("completion").on_attach(client)
		lsp_status.on_attach(client)

		-- vim.cmd [[ setlocal omnifunc=v:lua.vim.lsp.omnifunc ]]

		if client.resolved_capabilities.document_formatting then
			utils.keymap({
				"n",
				"<Leader>aa",
				"<cmd>lua require'rockerboo.utils'.lsp_format()<cr>",
				{},
			})
			print(string.format("Formatting supported %s", client.name))
		end
	end

	local default_lsp_config = { on_attach = on_attach_vim, capabilities = lsp_status.capabilities }

	local servers = { "tsserver", "gopls", "cssls", "vimls", "bashls" }

	for _, server in ipairs(servers) do
		config[server].setup(default_lsp_config)
	end

  config.tsserver.setup({on_attach = on_attach_vim, })
	config.elixirls.setup({ cmd = { "elixir-ls" }, on_attach = on_attach_vim })
	config.rust_analyzer.setup({ on_attach = on_attach_vim })

	require("lspconfig").efm.setup({
		on_attach = on_attach_vim,
		init_options = {
			documentFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
			completion = true,
		},
		settings = {
			-- Require formatter configuration files to load
			rootMarkers = {
				".lua-format",
				-- ".eslintrc.cjs",
				-- ".eslintrc",
				-- ".eslintrc.json",
				-- ".eslintrc.js",
				".prettierrc",
				".prettierrc.js",
				".prettierrc.json",
				".prettierrc.yml",
				".prettierrc.yaml",
				".prettier.config.js",
				".prettier.config.cjs",
			},
		},
	})

	require("nlua.lsp.nvim").setup(config, {
		cmd = {
			"/home/rockerboo/build/lua-language-server/bin/Linux/lua-language-server",
			"-E",
			"/home/rockerboo/build/lua-language-server/main.lua",
		},
		on_attach = on_attach_vim,
	})

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, { update_in_insert = false })
end

return { setup = setup }
