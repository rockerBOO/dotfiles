local lsp_status = require("lsp-status")
local utils = require("rockerboo.utils")

local on_attach_buffer = function(client)
	-- print("'" .. client.name .. "' language server attached")

	-- utils.log_to_file("/tmp/nvim-lsp-client.log")(vim.inspect(client))

	-- log_capabilities(client.resolved_capabilities)
	lsp_status.on_attach(client)

	local capLog = utils.log_to_file("/tmp/capabilities.log")
	capLog(
		"client.name: "
			.. client.name
			.. "\n"
			.. vim.inspect(client.server_capabilities)
	)

	-- if client.server_capabilities.document_formatting then
	-- 	utils.keymap({
	-- 		"n",
	-- 		"<Leader>aa",
	-- 		"<cmd>lua vim.lsp.buf.formatting()<cr>",
	-- 		{},
	-- 	})
	-- 	-- vim.api.nvim_define_augroup({ name = "Format" })
	-- 	-- vim.api.nvim_define_autocmd({
	-- 	-- 	group = "Format",
	-- 	-- 	event = "BufWritePre",
	-- 	-- 	pattern = "<buffer>",
	-- 	-- 	callback = function()
	-- 	-- 		vim.lsp.buf.formatting_seq_sync(nil, 2000, { "efm" })
	-- 	-- 	end,
	-- 	-- })

	-- 	-- print(string.format("Formatting supported %s", client.name))
	-- end

	if client.server_capabilities.document_highlight then
		vim.cmd([[
        augroup LSPDocumentHighlight
          au!
          autocmd CursorHold  <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorHoldI <buffer> lua vim.lsp.buf.document_highlight()
          autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
			  augroup END
      ]])
	end
end

return {
	on_attach_buffer = on_attach_buffer,
}
