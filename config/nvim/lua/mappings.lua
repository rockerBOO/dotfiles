local mappings = {}
local typescript = require("rockerboo.typescript")
local on_list = typescript.on_list

-- Helper variables
local n, i, t, c, v, esc = "n", "i", "t", "c", "v", "<esc>"
local silent = { silent = true }

function Reload(module)
	require("plenary.reload").reload_module(module)
end

local plenary_reload = function()
	require("plenary.reload").reload_module("telescope")
	require("plenary.reload").reload_module("plenary")
	require("plenary.reload").reload_module("boo-colorscheme")
	require("plenary.reload").reload_module("plugin")
	require("plenary.reload").reload_module("rust-tools")
	require("plenary.reload").reload_module("jester")
	Reload("lsp_config")
	Reload("plugin.telescope")
	-- require("plenary.reload").reload_module("lsp_extensions")
	-- require("boo-colorscheme").use({ theme = "sunset_cloud" })
	require("plugin.telescope").setup_defaults()
	-- require("setup").setup()
end

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

	{ n, "asdf", plenary_reload },

	-- LSP
	{
		n,
		"gd",
		function()
			vim.lsp.buf.definition({ on_list = on_list })
		end,
		silent,
	},
	{ n, "K", vim.lsp.buf.hover, silent },
	{ n, "c-k", vim.lsp.buf.signature_help, silent },

	{
		n,
		"gD",
		function()
			vim.lsp.buf.implementation({ on_list = on_list })
		end,
		silent,
	},
	{
		n,
		"1gD",
		function()
			vim.lsp.buf.type_definition({ on_list = on_list })
		end,
		silent,
	},
	-- { n, "gr", require("telescope.builtin").lsp_references, silent },
	{
		n,
		"gr",
		function()
			vim.lsp.buf.references(nil, { on_list = on_list })
		end,
		silent,
	},

	-- { n, "g0", "<cmd>lua vim.lsp.buf.document_symbol()<CR>", silent },
	-- { n, "gW", "<cmd>lua vim.lsp.buf.workspace_symbol()<CR>", silent },
	{ n, "<Leader>re", vim.lsp.buf.rename, silent },
	{ n, "<Leader>ca", vim.lsp.buf.code_action, silent },

	{
		n,
		"<c-]>",
		function()
			vim.lsp.buf.declaration({ on_list = on_list })
		end,
		silent,
	},
	{ n, "<Leader>di", vim.diagnostic.open_float, silent },

	-- Diagnostics movement
	{ n, "<Leader>k", vim.diagnostic.goto_prev },
	{ n, "<Leader>j", vim.diagnostic.goto_next },

	-- { n, "<leader>T", "<cmd>Ultest<cr>" },
	-- { n, "]t", "<plug>(ultest-next-fail)" },
	-- { n, "[t", "<plug>(ultest-prev-fail)" },
	--

	{ n, "<F7>", "<cmd>set list!<cr>" },
	{ i, "<F7>", "<C-o><cmd>set list!<cr>" },
	{ c, "<F7>", "<C-c><cmd>set list!<cr>" },

	-- Go to end of line
	{ n, "gl", "$" },

	-- Go to start of line
	{ n, "gb", "^" },

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
	{ n, "<Leader>w", ":w<cr>", { silent = true } },
	{ n, "<Leader>q", ":q<cr>", { silent = true } },

	{ i, "<C-l>", "A<cr>" },
	{ i, "<Tab>", "pumvisible() ? '<C-n>' : '<Tab>'", { expr = true } },
	{ i, "<S-Tab>", "pumvisible() ? '<C-p>' : '<S-Tab>'", { expr = true } },

	-- nvim-ts-hint-textobject
	{ v, "m", R("tsht").nodes, { silent = true } },

	-- jester
	{ n, "<Leader>dt", require("plugin.jester").yarn_debug },
	{ n, "<Leader>df", require("plugin.jester").yarn_debug_file },
	{ n, "<Leader>dl", require("plugin.jester").yarn_debug_last },

	{ n, "<Leader>tt", require("plugin.jester").yarn_test },
	{ n, "<Leader>tf", require("plugin.jester").yarn_test_file },
	-- j n, "<Leader>tl", require("plugin.jester").yarn_test_last },
	{
		n,
		"<Leader>tl",
		function()
			require("jester").run_last()
		end,
	},

	{ n, "<Leader>gh", "<cmd>TSHighlightCapturesUnderCursor<cr>", silent },

	{ n, "<Leader>ih", "<cmd>RustToggleInlayHints<cr>", silent },
}

-- Mappings
mappings.setup = function()
	-- Apply the keymaps
	require("rockerboo.utils").keymaps(maps)
end

return mappings
