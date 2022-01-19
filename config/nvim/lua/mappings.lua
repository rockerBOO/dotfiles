local mappings = {}

-- Helper variables
local n, i, t, c, v, esc = "n", "i", "t", "c", "v", "<esc>"
local silent = { silent = true }

-- @param {table} maps - mode, key, cmd, options
local maps = {
	-- Quick pane
	{ n, "<C-l>", "<C-w>l" },
	{ n, "<C-h>", "<C-w>h" },
	{ n, "<C-j>", "<C-w>j" },
	{ n, "<C-k>", "<C-w>k" },

	-- Treesitter quickfix
	{ n, "<leader><c-w>", ":write | edit | TSBufEnable highlight<cr><cr>" },

	-- {n, "<leader>hhi", ":TSPlaygroundToggle<cr>"},

	-- Escape
	{ i, "jk", esc },
	{ i, "JK", esc },
	{ i, "Jk", esc },
	{ i, "jK", esc },

	-- LSP
	{ n, "gd", vim.lsp.buf.definition, silent },
	{ n, "K", vim.lsp.buf.hover, silent },

	{ n, "gD", vim.lsp.buf.implementation, silent },
	-- { n, "1gD", vim.lsp.buf.type_definition, silent },
	{ n, "gr", require'telescope.builtin'.lsp_references, silent },

	-- { n, "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", silent },
	-- { n, "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", silent },
	{ n, "<Leader>re", vim.lsp.buf.rename, silent },

	{ n, "<c-]>", vim.lsp.buf.declaration, silent },
	{ n, "<Leader>di", vim.diagnostic.open_float, silent },

  -- Diagnostics movement
  { n, "<Leader>k", vim.diagnostic.goto_next },
  { n, "<Leader>j", vim.diagnostic.goto_next },

	-- { n, "<leader>T", "<cmd>Ultest<cr>" },
	-- { n, "]t", "<plug>(ultest-next-fail)" },
	-- { n, "[t", "<plug>(ultest-prev-fail)" },
  --

  { n, '<F7>', '<cmd>set list!<cr>' },
  { i, '<F7>', '<C-o><cmd>set list!<cr>' },
  { c, '<F7>', '<C-c><cmd>set list!<cr>' },

	{
		n,
		"<leader>hi",
		[[ <cmd>echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
	-- ]],
	},

	-- Escape for terminal (aka spam escape will get me out)
	{ t, "<esc><esc>", "<C-\\><C-n>" },

	-- { n, "<Space>", "10j" },
	-- { n, "<C-Space>", "10k" },

	-- { n, "<leader><leader>", "<c-^>" },

	-- { n, "<leader><CR>", ":noh<CR>", { silent = true } },

	-- Disable up/down in insert mode
	{ i, "<Up>", "<nop>" },
	{ i, "<Down>", "<nop>" },

	{ n, "<Left>", ":bp<cr>", silent },
	{ n, "<Right>", ":bp<cr>", silent },

	-- Quick quick file/buffer commands
	{ n, "<Leader>w", ":w<cr>" },
	{ n, "<Leader>q", ":q<cr>" },

	{ i, "<C-l>", "A<cr>" },
	{ i, "<Tab>", "pumvisible() ? '<C-n>' : '<Tab>'", { expr = true } },
	{ i, "<S-Tab>", "pumvisible() ? '<C-p>' : '<S-Tab>'", { expr = true } },

	-- nvim-ts-hint-textobject
	{ v, "m", R('tsht').nodes, { silent = true } },

	-- jester
	{ n, "<Leader>dt", require('plugin.jester').yarn_debug },
	{ n, "<Leader>df", require('plugin.jester').yarn_debug_file },
	{ n, "<Leader>dl", require('plugin.jester').yarn_debug_last },

	{ n, "<Leader>tt", require('plugin.jester').yarn_test },
	{ n, "<Leader>tf", require('plugin.jester').yarn_test_file },
	{ n, "<Leader>tl", require('plugin.jester').yarn_test_last },

	{ n, "<Leader>gh", "<cmd>TSHighlightCapturesUnderCursor<cr>", silent },
}

-- Mappings
mappings.setup = function()
	-- Apply the keymaps
	require("rockerboo.utils").keymaps(maps)
end

return mappings
