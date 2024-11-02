local set = vim.keymap.set
local silent = { silent = true }
local n = "n"

local add_newline = function(data)
	if type(data) == "table" then
		if data[#data] ~= "" then
			table.insert(data, "")
		end
	elseif type(data) == "string" then
		if data:sub(-1) ~= "\n" then
			data = data .. "\n"
		end
	end
	return data
end

local skip_blank_lines = function(data)
	if type(data) == "string" then
		data = vim.fn.split(data, "\n")
	end
	return vim.tbl_filter(function(line)
		return line ~= ""
	end, data)
end

local unindent = function(data)
	if type(data) == "string" then
		data = vim.fn.split(data, "\n")
	end
	return vim.tbl_map(vim.fn.trim, data)
end

vim.keymap.set(
	n,
	"<leader>tt",
	-- "<cmd>:sp<CR>:term python %<CR>",
	"<cmd>:sp<CR>:term mix test %<CR>",
	silent
)

vim.keymap.set(n, "<leader>tr", function()
	local position = vim.api.nvim_win_get_cursor(0)
	vim.print(position)

	local name = vim.api.nvim_buf_get_name(0)

	local buf = vim.api.nvim_create_buf(false, false)
	local winid = vim.api.nvim_open_win(buf, true, { split = "below" })
	local chan = vim.api.nvim_open_term(buf, {})
	local cmd = { "mix test --include line:" .. position[1] .. " " .. name }

	cmd = unindent(cmd)
	cmd = skip_blank_lines(cmd)
	cmd = add_newline(cmd)
	vim.api.nvim_chan_send(
		chan,
		vim.iter(cmd):fold("", function(acc, v)
			return acc .. v
		end)
	)
	-- "<cmd>:sp<CR>:term mix test %<CR>",
end, silent)

-- get the test blocks in elixir using treesitter
-- (call
-- 	target: (identifier) @block
-- 	(arguments) @t
-- 	(do_block) @b)

-- local capabilities = require("cmp_nvim_lsp").update_capabilities(
-- 	vim.lsp.protocol.make_client_capabilities()
-- )
-- require("elixir").setup({
-- 	cmd = "elixir-ls",
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
