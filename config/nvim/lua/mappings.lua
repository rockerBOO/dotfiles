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
	require("boo-colorscheme").use({ theme = "sunset_cloud" })
	require("plugin.telescope").setup_defaults()
	-- require("setup").setup()
end

-- @param {table} maps - mode, key, cmd, options
local maps = {
	-- Quick pane
	{ n, "<c-l>", "<c-w>l" },
	{ n, "<c-h>", "<c-w>h" },
	{ n, "<c-j>", "<c-w>j" },
	{ n, "<c-k>", "<c-w>k" },

	-- Treesitter quickfix
	{ n, "<leader><c-w>", ":write | edit | TSBufEnable highlight<cr><cr>" },

	-- {n, "<leader>hhi", ":TSPlaygroundToggle<cr>"},

	-- Escape
	{ i, "jk", esc },
	{ i, "JK", esc },
	{ i, "Jk", esc },
	{ i, "jK", esc },

	{ n, "<Leader>asdf", plenary_reload },

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

	{ n, "<Leader>gh", "<cmd>TSHighlightCapturesUnderCursor<cr>", silent },

	{ n, "<Leader>ih", "<cmd>RustToggleInlayHints<cr>", silent },
}

-- Mappings
mappings.setup = function()
	-- Apply the keymaps
	require("rockerboo.utils").keymaps(maps)
end

return mappings
