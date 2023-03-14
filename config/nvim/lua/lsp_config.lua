local status = require("rockerboo.lsp_status")
-- local f = require("rockerboo.functional")
local config = require("lspconfig")
local lsp = require("lsp")
local utils = require("rockerboo.utils")

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
	-- local on_attach_vim =

	-- EFM
	--

	local capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- Support snippets
	-- capabilities.textDocument.completion.completionItem.snippetSupport = true

	local default_lsp_config = {
		on_attach = lsp.on_attach_buffer,
		capabilities = capabilities,
		flags = {
			debounce_text_changes = 30,
		},
	}

	local servers = {
		"gopls",
		"cssls",
		"html",
		"vimls",
		"bashls",
		"sqlls",
		"pyright",
		"gleam",
	}

	for _, server in ipairs(servers) do
		config[server].setup(default_lsp_config)
	end

	-- local tsserver_capabilities = capabilities

	-- utils.log_to_file(vim.lsp.get_log_path())(vim.inspect(tsserver_capabilities))
	-- tsserver_capabilities["textDocument"]["formatting"] = false

	-- config["tsserver"].setup({
	-- 	cmd = {
	-- 		"typescript-language-server",
	-- 		"--stdio",
	-- 		"--log-level=4",
	-- 		"--tsserver-log-file=/tmp/tsserver.log",
	-- 	},
	-- 	capabilities = tsserver_capabilities,
	-- 	init_options = require("nvim-lsp-ts-utils").init_options,
	-- 	on_attach = function(client)
	-- 		client.server_capabilities.document_formatting = false

	-- 		require("nvim-lsp-ts-utils").setup({
	-- 			eslint_enable_code_actions = false,
	-- 			eslint_enable_diagnostics = false,
	-- 			signature_help_in_parens = true,
	-- 			auto_inlay_hints = false,
	-- 		})

	-- 		require("nvim-lsp-ts-utils").setup_client(client)

	-- 		return lsp.on_attach_buffer(client)
	-- 	end,
	-- })
	--
	-- local lsp = require("lsp")
	-- local tsserver_capabilities = require("cmp_nvim_lsp").default_capabilities()

	-- utils.log_to_file("/tmp/cap.log")(vim.inspect(capabilities))

	-- tsserver_capabilities["textDocument"]["formatting"] = false
	--
	-- require("typescript").setup({
	-- 	debug = true,
	-- 	server = {
	-- 		on_attach = lsp.on_attach_buffer,
	-- 		capabilities = tsserver_capabilities,
	-- 	},
	-- })

	-- config.efm.setup({
	-- 	capabilities = capabilities,
	-- 	on_attach = lsp.on_attach_buffer,
	-- })

	config.ruff_lsp.setup({
		cmd = { "/home/rockerboo/code/ruff-lsp/ruff-lsp" },
		capabilities = capabilities,
		on_attach = lsp.on_attach_buffer,
		settings = {
			["ruff.organizeImports"] = false,
			["ruff.fixAll"] = false,
			["source.organizeImports"] = false,
			["source.fixAll"] = false,
			["source.organizeImports.ruff"] = false,
			["source.fixAll.ruff"] = false,
		},
	})

	config.jsonls.setup({
		capabilities = capabilities,
		on_attach = lsp.on_attach_buffer,
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
		on_attach = lsp.on_attach_buffer,
		capabilities = capabilities,
		filetypes = {
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"javascript.jsx",
			"vue",
		},
		settings = {
			["eslint.packageManager"] = "yarn",
			["eslint.debug"] = true,
		},
	})

	config.elixirls.setup({
		cmd = { "elixir-ls" },
		capabilities = capabilities,
		on_attach = lsp.on_attach_buffer,
	})

	-- using rust-tools.nvim to connect
	-- config.rust_analyzer.setup({
	-- 	on_attach = on_attach_vim,
	-- 	capabilities = vim.lsp.protocol.make_client_capabilities(),
	-- 	settings = {
	-- 		["rust-analyzer"] = {
	-- 			diagnostics = {
	-- 				experimental = true,
	-- 			},
	-- 		},
	-- 	},
	-- })

	config.erlangls.setup({
		capabilities = capabilities,
		on_attach = lsp.on_attach_buffer,
	})

	-- require("nlua.lsp.nvim").setup(config, {
	-- 	cmd = {
	-- 		"/home/rockerboo/build/lua-language-server/bin/lua-language-server",
	-- 		"-E",
	-- 		"/home/rockerboo/build/lua-language-server/main.lua",
	-- 	},
	-- 	on_attach = lsp.on_attach_buffer,
	-- })
	require("lspconfig").lua_ls.setup({

		capabilities = capabilities,
		cmd = {
			"/mnt/900/builds/lua-language-server/bin/lua-language-server",
			"-E",
			"/mnt/900/builds/lua-language-server/main.lua",
		},
		settings = {
			Lua = {
				runtime = {
					-- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
					version = "LuaJIT",
				},
				diagnostics = {
					-- Get the language server to recognize the `vim` global
					globals = { "vim" },
				},
				workspace = {
					-- Make the server aware of Neovim runtime files
					library = vim.api.nvim_get_runtime_file("", true),
				},
				-- Do not send telemetry data containing a randomized but unique identifier
				telemetry = {
					enable = false,
				},
			},
		},
		on_attach = lsp.on_attach_buffer,
	})

	require("lspconfig").ltex.setup({
		capabilities = capabilities,
		on_attach = lsp.on_attach_buffer,
		cmd = { "/mnt/900/builds/ltex-ls-15.2.0/bin/ltex-ls" },
		settings = {
			ltex = {
				language = "en",
				additionalRules = {
					enablePickyRules = true,
					motherTongue = "en",
					languageModel = "/mnt/900/ngrams/ngrams-en-20150817/",
				},
			},
		},
	})

	-- require("lspconfig").markdown_language_server.setup({
	-- 	on_attach = lsp.on_attach_buffer,
	-- 	capabilities = capabilities,
	-- })

	require("lspconfig").marksman.setup({
		on_attach = lsp.on_attach_buffer,
		capabilities = capabilities,
	})

	require("lspconfig").rome.setup({
		on_attach = lsp.on_attach_buffer,
		capabilities = capabilities,
		cmd = { "yarn", "run", "rome", "lsp-proxy" },
	})
end

return { setup = setup }
