local lsp_status = require("lsp-status")
local status = require("rockerboo.lsp_status")
local utils = require("rockerboo.utils")
-- local f = require("rockerboo.functional")
local config = require("lspconfig")

-- vim.lsp.set_log_level("debug")

local setup = function()
	status.activate()

	-- local log_capabilities = function(capabilities)
	-- 	-- @param filter = table {"hover"}
	-- 	local reduce = function(filter)
	-- 		local result = {}
	-- 		for k, _ in pairs(capabilities) do
	-- 			table.insert(
	-- 				result,
	-- 				f.map(function(v)
	-- 					return { v = capabilities[v] }
	-- 				end)(f.filter(f.contains(k))(filter))
	-- 			)
	-- 		end
	-- 		return f.flatten(result)
	-- 	end

	-- 	-- local log = utils.log_to_file("/tmp/neovim-lsp-capabilities.log")
	-- 	-- log(vim.inspect(reduce(capabilities)))
	-- end

	--- Language servers
	local on_attach_vim = function(client)
		-- print("'" .. client.name .. "' language server attached")

		-- utils.log_to_file("/tmp/nvim-lsp-client.log")(vim.inspect(client))

		-- log_capabilities(client.resolved_capabilities)

		lsp_status.on_attach(client)

		local capLog = utils.log_to_file("/tmp/capabilities.log")
		capLog(
			"client.name: "
				.. client.name
				.. "\n"
				.. vim.inspect(client.resolved_capabilities)
		)

		if client.resolved_capabilities.document_formatting then
			utils.keymap({
				"n",
				"<Leader>aa",
				"<cmd>lua vim.lsp.buf.formatting()<cr>",
				{},
			})
			-- vim.api.nvim_define_augroup({ name = "Format" })
			-- vim.api.nvim_define_autocmd({
			-- 	group = "Format",
			-- 	event = "BufWritePre",
			-- 	pattern = "<buffer>",
			-- 	callback = function()
			-- 		vim.lsp.buf.formatting_seq_sync(nil, 2000, { "efm" })
			-- 	end,
			-- })

			-- print(string.format("Formatting supported %s", client.name))
		end
	end

	-- EFM
	--

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

	-- Support snippets
	-- capabilities.textDocument.completion.completionItem.snippetSupport = true

	local default_lsp_config = {
		on_attach = on_attach_vim,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 30,
		},
	}

	local servers = { "gopls", "cssls", "html", "vimls", "bashls" }

	for _, server in ipairs(servers) do
		config[server].setup(default_lsp_config)
	end

	local tsserver_capabilities = capabilities

	-- utils.log_to_file(vim.lsp.get_log_path())(vim.inspect(tsserver_capabilities))
	tsserver_capabilities["textDocument"]["formatting"] = false

	config["tsserver"].setup({
		cmd = {
			"typescript-language-server",
			"--stdio",
			"--log-level=4",
			"--tsserver-log-file=/tmp/tsserver.log",
		},
		capabilities = tsserver_capabilities,
		init_options = require("nvim-lsp-ts-utils").init_options,
		on_attach = function(client)
			client.resolved_capabilities.document_formatting = false

			require("nvim-lsp-ts-utils").setup({
				eslint_enable_code_actions = false,
				eslint_enable_diagnostics = false,
				signature_help_in_parens = true,
				auto_inlay_hints = false,
			})

			require("nvim-lsp-ts-utils").setup_client(client)

			return on_attach_vim(client)
		end,
	})

	config.efm.setup({
		capabilities = capabilities,
		on_attach = on_attach_vim,
	})

	config.jsonls.setup({
		capabilities = capabilities,
		on_attach = on_attach_vim,
		settings = {
			json = {
				schemas = {
					{
						fileMatch = { "package.json" },
						url = "https://json.schemastore.org/package.json",
					},
					{
						fileMatch = { "tsconfig.json", "tsconfig.*.json" },
						url = "http://json.schemastore.org/tsconfig",
					},
					{
						fileMatch = { ".eslintrc.json", ".eslintrc" },
						url = "http://json.schemastore.org/eslintrc",
					},
					{
						fileMatch = {
							".prettierrc",
							".prettierrc.json",
							"prettier.config.json",
						},
						url = "http://json.schemastore.org/prettierrc",
					},
					{
						fileMatch = {
							".stylelintrc",
							".stylelintrc.json",
							"stylelint.config.json",
						},
						url = "http://json.schemastore.org/stylelintrc",
					},
				},
			},
		},
	})

	-- Using typescript plugin for eslint?
	config.eslint.setup({
		on_attach = on_attach_vim,
		capabilities = capabilities,
		filetypes = {
			"javascript",
			"javascriptreact",
			"javascript.jsx",
			"vue",
		},
	})

	config.elixirls.setup({
		cmd = { "elixir-ls" },
		capabilities = capabilities,
		on_attach = on_attach_vim,
	})
	config.rust_analyzer.setup({
		on_attach = on_attach_vim,
		capabilities = vim.lsp.protocol.make_client_capabilities(),
	})

	require("nlua.lsp.nvim").setup(config, {
		cmd = {
			"/home/rockerboo/build/lua-language-server/bin/Linux/lua-language-server",
			"-E",
			"/home/rockerboo/build/lua-language-server/main.lua",
		},
		on_attach = on_attach_vim,
	})

	require("lspconfig").ltex.setup({
		cmd = { "/home/rockerboo/build/ltex-ls-15.2.0/bin/ltex-ls" },
    settings = {
      ltex = {
        language = 'en',
        additionalRules = {
          enablePickyRules = true,
          motherTongue = 'en',
          languageModel = '/mnt/900/ngrams/ngrams-en-20150817/'
        }
      }
    }
	})

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
		vim.lsp.diagnostic.on_publish_diagnostics,
		{ virtual_text = false, update_in_insert = false }
	)
end

return { setup = setup }
