local typescript = require("rockerboo.typescript")
local on_list = typescript.on_list

local set = vim.keymap.set
local del = vim.keymap.del
local n = "n"

local group = vim.api.nvim_create_augroup("LspMappings", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(args)
		local opts = { buffer = args.buf, silent = true }

		set(n, "gd", function()
			vim.lsp.buf.definition({ on_list = on_list })
		end, opts)
		set(n, "K", vim.lsp.buf.hover, opts)
		set(n, "<c-s-K>", vim.lsp.buf.signature_help, opts)

		set(n, "gD", function()
			vim.lsp.buf.implementation({ on_list = on_list })
		end, opts)

		set(n, "1gD", function()
			vim.lsp.buf.type_definition({ on_list = on_list })
		end, opts)
		set(n, "gr", function()
			vim.lsp.buf.references()
		end, opts)

		set(n, "<c-]>", function()
			vim.lsp.buf.declaration({ on_list = on_list })
		end, opts)

		set(n, "<Leader>re", vim.lsp.buf.rename, opts)
		set(n, "<Leader>ca", vim.lsp.buf.code_action, opts)

		-- diagnostics
		set(n, "<Leader>di", vim.diagnostic.open_float, opts)
		set(n, "<Leader>k", vim.diagnostic.goto_prev, opts)
		set(n, "<Leader>j", vim.diagnostic.goto_next, opts)
	end,
})

-- vim.api.nvim_create_autocmd("LspDetach", {
-- 	group = group,
-- 	callback = function(args)
-- 		local opts = { buffer = args.buf }
--
-- 		-- vim.keymap.del errors if keymap doesn't exist
-- 		-- so we get one of the keymaps that should exist
-- 		-- and exit if it doesn't exist
-- 		local has_keymap = vim.tbl_filter(function(v)
-- 			return v.lhs == "gd"
-- 		end, vim.api.nvim_buf_get_keymap(args.buf, n))
--
-- 		if #has_keymap == 0 then
-- 			return
-- 		end
--
-- 		del(n, "gd", opts)
-- 		del(n, "K", opts)
-- 		del(n, "<c-k>", opts)
--
-- 		del(n, "gD", opts)
--
-- 		del(n, "1gD", opts)
-- 		del(n, "gr", opts)
--
-- 		del(n, "<c-]>", opts)
--
-- 		del(n, "<Leader>re", opts)
-- 		del(n, "<Leader>ca", opts)
--
-- 		-- diagnostics
-- 		del(n, "<Leader>di", opts)
-- 		del(n, "<Leader>k", opts)
-- 		del(n, "<Leader>j", opts)
-- 	end,
-- })
