local mappings = {}

-- Just reduce the length and maybe some memory :)
local n, i, t, o, v, esc = "n", "i", "t", "o", "v", "<esc>"
local silent = { silent = true }

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
	{ n, "gd", "<cmd>lua vim.lsp.buf.definition()<cr>", silent },
	{ n, "K", "<cmd>lua vim.lsp.buf.hover()<cr>", silent },

	{ n, "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>", silent },
	{ n, "1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", silent },
	{ n, "gr", "<cmd>lua require'telescope.builtin'.lsp_references{}<CR>", silent },

	{ n, "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", silent },
	{ n, "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", silent },
	{ n, "<Leader>re", "<cmd>lua vim.lsp.buf.rename()<CR>", silent },

	{ n, "<c-]>", "<cmd>lua vim.lsp.buf.declaration()<CR>", silent },
	{ n, "<Leader>di", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", silent },

	{ n, "<leader>T", "<cmd>Ultest<cr>" },
	{ n, "]t", "<plug>(ultest-next-fail)" },
	{ n, "[t", "<plug>(ultest-prev-fail)" },

	{
		n,
		"<leader>hi",
		[[ <cmd>echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
	-- ]],
	},

	-- Escape for terminal (aka spam escape will get me out)
	{ t, "<esc><esc>", "<C-\\><C-n>" },

	{ n, "<Space>", "10j" },
	{ n, "<C-Space>", "10k" },

	-- { n, "<leader><leader>", "<c-^>" },

	-- { n, "<leader><CR>", ":noh<CR>", { silent = true } },

	-- Disable up/down in insert mode
	{ i, "<Up>", "<nop>" },
	{ i, "<Down>", "<nop>" },

	{ n, "<Left>", ":bp<cr>", { silent = true } },
	{ n, "<Right>", ":bp<cr>", { silent = true } },

	-- Quick quick file/buffer commands
	{ n, "<Leader>w", ":w<cr>" },
	{ n, "<Leader>q", ":q<cr>" },

	{ i, "<C-l>", "A<cr>" },
	{ i, "<Tab>", "pumvisible() ? '<C-n>' : '<Tab>'", { expr = true } },
	{ i, "<S-Tab>", "pumvisible() ? '<C-p>' : '<S-Tab>'", { expr = true } },

	-- nvim-ts-hint-textobject
	{ v, "m", "<cmd>lua R('tsht').nodes()<CR>", { silent = true } },
	{ o, "m", "<cmd><C-U>lua R('tsht').nodes()<CR>", { silent = true } },

	-- jester
	{ v, "<Leader>t", "<cmd>lua R('jester').run({ cmd = \"jest -t '$result' -- $file\" })" },

	{ n, "<Leader>gh", "<cmd>TSHighlightCapturesUnderCursor<cr>", silent },
}

-- Mappings
mappings.setup = function()
	-- Apply the keymaps
	require("rockerboo.utils").keymaps(maps)
end

return mappings
