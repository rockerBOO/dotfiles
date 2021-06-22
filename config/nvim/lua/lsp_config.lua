local lsp_status = require("lsp-status")
local status = require("rockerboo.lsp_status")
local utils = require("rockerboo.utils")
local f = require("rockerboo.functional")
local config = require("lspconfig")

-- vim.lsp.set_log_level("debug")

local setup = function()
	status.activate()

	--- [[
	-- {
	--   call_hierarchy = false,
	--   code_action = {
	--     codeActionKinds = { "", "quickfix", "refactor.rewrite", "refactor.extract" },
	--     resolveProvider = false
	--   },
	--   completion = true,
	--   declaration = false,
	--   document_formatting = false,
	--   document_highlight = true,
	--   document_range_formatting = false,
	--   document_symbol = true,
	--   execute_command = true,
	--   find_references = true,
	--   goto_definition = true,
	--   hover = true,
	--   implementation = false,
	--   rename = true,
	--   signature_help = true,
	--   signature_help_trigger_characters = { "(", "," },
	--   text_document_did_change = 2,
	--   text_document_open_close = true,
	--   text_document_save = false,
	--   text_document_save_include_text = false,
	--   text_document_will_save = false,
	--   text_document_will_save_wait_until = false,
	--   type_definition = false,
	--   workspace_folder_properties = {
	--     changeNotifications = false,
	--     supported = false
	--   },
	--   workspace_symbol = true
	-- }
	-- ]]

	local log_capabilities = function(capabilities)
		-- @param filter = table {"hover"}
		local reduce = function(filter)
			local result = {}
			for k, _ in pairs(capabilities) do
				table.insert(
					result,
					f.map(function(v)
						return { v = capabilities[v] }
					end)(f.filter(f.contains(k))(filter))
				)
			end
			return f.flatten(result)
		end

		-- local log = utils.log_to_file("/tmp/neovim-lsp-capabilities.log")
		-- log(vim.inspect(reduce(capabilities)))
	end

	--- Language servers
	local on_attach_vim = function(client, bufnr)
		print("'" .. client.name .. "' language server attached")

		-- utils.log_to_file("/tmp/nvim-lsp-client.log")(vim.inspect(client))

		-- log_capabilities(client.resolved_capabilities)

		lsp_status.on_attach(client)

		-- vim.cmd([[ setlocal omnifunc=v:lua.vim.lsp.omnifunc ]])

		local capLog = utils.log_to_file("/tmp/capabilities.log")
		capLog("client.name: " .. client.name .. "\n" .. vim.inspect(client.resolved_capabilities))

		if client.resolved_capabilities.document_formatting then
			utils.keymap({
				"n",
				"<Leader>aa",
				"<cmd>lua vim.lsp.buf.formatting()<cr>",
				{},
			})
			vim.api.nvim_command([[augroup Format]])
			vim.api.nvim_command([[autocmd! * <buffer>]])
			vim.api.nvim_command([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync(nil, 750, {"efm"})]])
			vim.api.nvim_command([[augroup END]])
			-- vim.cmd([[ autocmd BufWritePre * :lua vim.lsp.buf.formatting_sync(nil, 500) ]])
			-- if client.name ~= "tsserver" then
			-- end

			print(string.format("Formatting supported %s", client.name))
		end
	end

	-- EFM
	--

	local capabilities = vim.lsp.protocol.make_client_capabilities()
	capabilities.textDocument.completion.completionItem.snippetSupport = true
	local default_lsp_config = { on_attach = on_attach_vim, capabilities = capabilities }

	local servers = { "gopls", "cssls", "vimls", "bashls" }

	for _, server in ipairs(servers) do
		config[server].setup(default_lsp_config)
	end

	local tsserver_capabilities = capabilities

	-- utils.log_to_file(vim.lsp.get_log_path())(vim.inspect(tsserver_capabilities))
	tsserver_capabilities["textDocument"]["formatting"] = false

	config["tsserver"].setup({
		-- cmd = "typescript-language-server --stdio --log-level=4 --tsserver-log-file=/tmp/tsserver.log",
		capabilities = tsserver_capabilities,
		on_attach = function(client, bufnr)
			require("nvim-lsp-ts-utils").setup({
				-- defaults
				disable_commands = false,
				enable_import_on_completion = false,
				import_on_completion_timeout = 5000,
				signature_help_in_parens = true,
			})

			return on_attach_vim(client, bufnr)
		end,
	})

	require("lspconfig").efm.setup({
		on_attach = on_attach_vim,
		init_options = {
			documentFormatting = true,
			hover = true,
			documentSymbol = true,
			codeAction = true,
		},
			-- settings = {
			-- 	-- Require formatter configuration files to load
			-- 	rootMarkers = {
			-- 		".lua-format",
			-- 		-- ".eslintrc.cjs",
			-- 		-- ".eslintrc",
			-- 		-- ".eslintrc.json",
			-- 		-- ".eslintrc.js",
			-- 		".prettierrc",
			-- 		".prettierrc.js",
			-- 		".prettierrc.json",
			-- 		".prettierrc.yml",
			-- 		".prettierrc.yaml",
			-- 		".prettier.config.js",
			-- 		".prettier.config.cjs",
			-- 	},
			-- },
	})

	config.elixirls.setup({ cmd = { "elixir-ls" }, on_attach = on_attach_vim })
	config.rust_analyzer.setup({ on_attach = on_attach_vim })

	require("nlua.lsp.nvim").setup(config, {
		cmd = {
			"/home/rockerboo/build/lua-language-server/bin/Linux/lua-language-server",
			"-E",
			"/home/rockerboo/build/lua-language-server/main.lua",
		},
		on_attach = on_attach_vim,
	})

	vim.lsp.handlers["textDocument/publishDiagnostics"] =
		vim.lsp.with(
			vim.lsp.diagnostic.on_publish_diagnostics,
			{ virtual_text = false, update_in_insert = false }
		)
end

return { setup = setup }
