
-- local capabilities = require("cmp_nvim_lsp").update_capabilities(
-- 	vim.lsp.protocol.make_client_capabilities()
-- )
-- require("elixir").setup({
-- 	cmd = { "elixir-ls" },
-- 	capabilities = capabilities,
-- 	on_attach = function(client, bufnr)
-- 		print("Connected to elixir ls")
-- 		require("lsp").on_attach_buffer(client, bufnr)
--
-- 		local map_opts = { buffer = true, noremap = true }
-- 		vim.keymap.set("n", "<leader>co", function()
-- 			vim.cmd([[ echo codelens run ]])
-- 			vim.lsp.codelens.run()
-- 		end, map_opts)
-- 	end,
-- })