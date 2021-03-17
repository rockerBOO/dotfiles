local mappings = {}

-- Just reduce the length and maybe some memory :)
local n, i, t, esc = "n", "i", "t", "<esc>"
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
	{ n, "<Leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", silent },

	{ n, "<c-]>", "<cmd>lua vim.lsp.buf.declaration()<CR>", silent },
	{ n, "<Leader>di", "<cmd>lua vim.lsp.util.show_line_diagnostics()<CR>", silent },

	{ n, "<leader>T", "<cmd>Ultest<cr>" },
	{ n, "]t", "<plug>(ultest-next-fail)" },
	{ n, "[t", "<plug>(ultest-prev-fail)" },

	-- {n, "<leader>hi", [[ <cmd>echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
	-- ]]},

	{ t, "<esc><esc>", "<C-\\><C-n>" },
	-- {i, "kj", esc},
	-- {i, "KJ", esc},
	-- {i, "Kj", esc},
	-- {i, "kJ", esc},

	-- {i, "kk", esc},
	-- {i, "KK", esc},

	-- {i, "jj", esc},
	-- {i, "JJ", esc},

	-- {i, "hj", esc},
	-- {i, "HJ", esc},
	-- {i, "Hj", esc},
	-- {i, "hJ", esc},

	-- {i, "kl", esc},
	-- {i, "KL", esc},
	-- {i, "Kl", esc},
	-- {i, "kL", esc},

	-- Disable up/down in insert mode
	{ i, "<Up>", "<nop>" },
	{ i, "<Down>", "<nop>" },

	-- Quick quick file/buffer commands
	{ n, "<Leader>w", ":w<cr>" },
	{ n, "<Leader>q", ":q<cr>" },

	{ i, "<C-l>", "A<cr>" },
	{ i, "<Tab>", "pumvisible() ? '<C-n>' : '<Tab>'", { expr = true } },
	{ i, "<S-Tab>", "pumvisible() ? '<C-p>' : '<S-Tab>'", { expr = true } },



	{ n, "<Leader>gh", "<cmd>TSHighlightCapturesUnderCursor<cr>", silent },
}

-- Mappings
mappings.setup = function()
	-- Apply the keymaps
	require("rockerboo.utils").keymaps(maps)
end

return mappings
