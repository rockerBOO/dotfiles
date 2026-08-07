-- local on_list = typescript.on_list

local set = vim.keymap.set
local n = "n"

local group = vim.api.nvim_create_augroup("LspMappings", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
	group = group,
	callback = function(args)
		local opts = { buffer = args.buf, silent = true }

		set(n, "gd", function()
			-- vim.lsp.buf.definition({ on_list = on_list })
			vim.lsp.buf.definition({})
		end, opts)
		set(n, "K", vim.lsp.buf.hover, opts)
		set(n, "<c-s-K>", vim.lsp.buf.signature_help, opts)

		set(n, "gD", function()
			vim.lsp.buf.implementation({})
		end, opts)

		set(n, "1gD", function()
			vim.lsp.buf.type_definition({})
		end, opts)
		set(n, "gr", function()
			-- vim.lsp.buf.references()
			require("telescope.builtin").lsp_references()
		end, opts)

		set(n, "<c-]>", function()
			vim.lsp.buf.declaration({})
		end, opts)

		-- set(n, "<Leader>re", vim.lsp.buf.rename, opts)
		local rename_opts = { buffer = args.buf, silent = true, expr = true }
		set(n, "<Leader>re", function()
			return ":IncRename " .. vim.fn.expand("<cword>")
		end, rename_opts)
		set(n, "<Leader>ca", vim.lsp.buf.code_action, opts)

		set(n, "<Leader>ih", function()
			vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
		end, opts)

    set(n, "<Leader>co", function()
      vim.lsp.document_color.color_presentation()
    end, opts)

		-- diagnostics
		set(n, "<Leader>di", vim.diagnostic.open_float, opts)
		set(n, "<Leader>k", function()
			vim.diagnostic.jump({ float = true, count = -1 })
		end, opts)
		set(n, "<Leader>j", function()
			vim.diagnostic.jump({ float = true, count = 1 })
		end, opts)
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
