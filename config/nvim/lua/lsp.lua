local lsp_status = require("lsp-status")
local utils = require("rockerboo.utils")
-- utils.log_to_file("/tmp/nvim-lsp-client.log")(vim.inspect(client))

local on_attach_buffer = function(client, bufnr)
	-- print("'" .. client.name .. "' language server attached")

	utils.log_to_file("/tmp/nvim-lsp-client.log")(vim.inspect(client))

	lsp_status.on_attach(client)

	local capLog = utils.log_to_file("/tmp/capabilities.log")
	capLog(
		"client.name: "
			.. client.name
			.. "\n"
			.. vim.inspect(client.server_capabilities)
	)

	-- if client.server_capabilities.document_formatting then
	-- utils.keymap({
	-- 	"n",
	-- 	"<Leader>aa",
	-- 	"<cmd>lua vim.lsp.buf.formatting()<cr>",
	-- 	{},
	-- })
	-- vim.api.nvim_define_augroup({ name = "Format" })
	-- vim.api.nvim_define_autocmd({
	-- 	group = "Format",
	-- 	event = "BufWritePre",
	-- 	pattern = "<buffer>",
	-- 	callback = function()
	-- 		vim.lsp.buf.format({
	-- 			timeout_ms = 1000,
	-- 			filter = function(c)
	-- 				return c.name ~= "tsserver"
	-- 			end,
	-- 		})
	-- 	end,
	-- })
	--
	-- vim.cmd(
	-- 	"echo " .. string.format("Formatting supported %s", client.name)
	-- )
	-- end

	local caps = client.server_capabilities

	if caps.documentHighlightProvider then
		local group = vim.api.nvim_create_augroup("LSPDocumentHighlight", {})

		vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
			buffer = bufnr,
			group = group,
			callback = function()
				vim.lsp.buf.document_highlight()
			end,
		})
		vim.api.nvim_create_autocmd({ "CursorMoved" }, {
			buffer = bufnr,
			group = group,
			callback = function()
				vim.lsp.buf.clear_references()
			end,
		})
	end

	if caps.semanticTokensProvider and caps.semanticTokensProvider.full then
		local augroup = vim.api.nvim_create_augroup("SemanticTokens", {})
		vim.api.nvim_create_autocmd("TextChanged", {
			group = augroup,
			buffer = bufnr,
			callback = function()
				if vim.lsp.buf.semantic_tokens_full then
					vim.lsp.buf.semantic_tokens_full()
				end
			end,
		})
		if vim.lsp.buf.semantic_tokens_full then
			-- fire it first time on load as well
			vim.lsp.buf.semantic_tokens_full()
		end
	end
end

return {
	on_attach_buffer = on_attach_buffer,
}
