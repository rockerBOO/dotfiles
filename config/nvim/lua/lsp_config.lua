local lsp = require("rockerboo.lsp")

local setup = function()
	local capabilities = {
		textDocument = {
			foldingRange = {
				dynamicRegistration = false,
				lineFoldingOnly = true,
			},
		},
	}
	-- require("blink.cmp").get_lsp_capabilities(capabilities)
	-- capabilities = vim.lsp.get_lsp_capabilities(capabilities)

	vim.lsp.config("*", {
		on_attach = lsp.on_attach_buffer,
		capabilities = capabilities,
		root_markers = { ".git" },
		flags = {
			debounce_text_changes = 50,
		},
	})

	-- Support snippets
	-- capabilities.textDocument.completion.completionItem.snippetSupport = true
	vim.lsp.config("biome", {
		-- cmd = { "yarn", "biome", "lsp-proxy" },
		cmd = { "biome", "lsp-proxy" },

		on_attach = function(client, bufnr)
			lsp.on_attach_buffer(client, bufnr)

			-- Apply all Biome fixes on save
			vim.api.nvim_create_autocmd("BufWritePre", {
				buffer = bufnr,
				callback = function()
					local diagnostics = vim.diagnostic.get(bufnr)
					local has_biome_issues = false
					local lsp_diagnostics = {}

					-- Convert to LSP format
					for _, diagnostic in ipairs(diagnostics) do
						if
							diagnostic.source == "biome"
							and diagnostic.user_data
							and diagnostic.user_data.lsp
						then
							has_biome_issues = true
							table.insert(
								lsp_diagnostics,
								diagnostic.user_data.lsp
							)
						end
					end

					if has_biome_issues then
						vim.lsp.buf.code_action({
							context = {
								only = { "source.fixAll.biome" },
								diagnostics = lsp_diagnostics,
							},
							apply = true,
						})
					end
				end,
			})
		end,
	})

	vim.lsp.config("yamlls", {
		settings = {
			yaml = {
				schemaStore = {
					-- You must disable built-in schemaStore support if you want to use
					-- this plugin and its advanced options like `ignore`.
					enable = false,
				},
				validate = { enable = true },
				schemas = require("schemastore").yaml.schemas(),
			},
			redhat = {
				telemetry = {
					enabled = false,
				},
			},
		},
	})

	vim.lsp.config("gdscript", {
		on_attach = lsp.on_attach_buffer,
		filetypes = { "gd", "gdscript", "gdscript3" },
	})

	vim.lsp.config("jsonls", {
		capabilities = capabilities,
		on_attach = lsp.on_attach_buffer,
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
				validate = { enable = true },
			},
		},
	})

	vim.lsp.config("elixirls", {
		cmd = { "elixir-ls" },
		capabilities = capabilities,
		on_attach = lsp.on_attach_buffer,
	})

	vim.lsp.config("erlangls", {
		capabilities = capabilities,
		on_attach = lsp.on_attach_buffer,
	})

	vim.lsp.config("marksman", {
		on_attach = lsp.on_attach_buffer,
		capabilities = capabilities,
	})

	vim.lsp.config("texlab", {
		setting = {
			texlab = {
				forwardSearch = {
					executable = "zathura",
					args = {
						"--synctex-editor-command",
						[[nvim-texlabconfig -file '%%%{input}' -line %%%{line} -server ]]
							.. vim.v.servername,
						"--synctex-forward",
						"%l:1:%f",
						"%p",
					},
				},
			},
		},
	})

	local servers = {
		"gopls",
		"cssls",
		"html",
		"vimls",
		"bashls",
		"sqlls",
		"gleam",
		"superhtml",
		"ts_ls",
		"crystalline",
		"pyright",
		"terraformls",
		"gdscript",
		-- "vale_ls",
		"clangd",
		"tinymist",
		-- "biome",
		-- "lua_ls",
		-- "texlab"
		-- "pylsp",
		-- "biome",
		-- "pylyzer",
	}

	-- for i in pairs(servers) do
	-- 	config[servers[i]].setup({})
	-- end
	vim.lsp.enable(servers)

	local native_servers = {
		-- "pyright",
		"ruff",
		-- "ty",
		-- "lua_ls",
	}

	vim.lsp.enable(native_servers)
end

return { setup = setup }
