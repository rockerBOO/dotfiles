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
	require("boo-colorscheme").use({})
	require("plugin.telescope").setup_defaults()
	require("mappings").setup()
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

	{
		n,
		"<leader>hi",
		[[ <cmd>echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<' . synIDattr(synID(line("."),col("."),0),"name") . "> lo<" . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
	-- ]],
	},

	{ n, "gh", "^" },
	{ n, "gl", "$" },

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

	{ n, "<C-d>", "<C-d>zz" },
	{ n, "<C-u>", "<C-u>zz" },

	{ n, "n", "nzzzv" },
	{ n, "N", "Nzzzv" },

	-- override to use black hole buffer for delete
	-- { n, "dd", "\"_dd" },
	-- { v, "d", "\"_d" },

	-- really cool?
	-- { "x", "<leader>p", '"_Dp' },

	-- nvim-ts-hint-textobject
	{ v, "m", R("tsht").nodes, silent },

	{ n, "<Leader>gh", "<cmd>TSHighlightCapturesUnderCursor<cr>", silent },

	-- { n, "<leader>r", require('rockerboo.scratch').run_script, silent },

	-- { n, "<leader>rr", "<cmd>:sp<CR>:term python %<CR>", silent },
	{ n, "<leader>rr", "<cmd>:RustLastRun<CR>", silent },
	-- { n, "<leader>rr", "<cmd>:sp<CR>:term source .env && accelerate launch %<CR>", silent },
	-- { n, "<leader>rr", "<cmd>:sp<CR>:term bun %<CR>", silent },
	{
		n,
		"<leader>ts",
		"<cmd>:sp<CR>:term source /home/rockerboo/code/others/VALL-E-X/.env && python /home/rockerboo/code/others/VALL-E-X/test.py --file % && audio-player -v 0.2 /home/rockerboo/code/others/VALL-E-X/completed-compiling.wav<CR>",
		silent,
	},
	{
		n,
		"<leader>tr",
		"<cmd>:sp<cr>:term cd /home/rockerboo/code/others/VALL-E-X && source /home/rockerboo/code/others/VALL-E-X/.env && python /home/rockerboo/code/others/VALL-E-X/test.py --file % && audio-player -v 0.2 completed-compiling.wav<cr>",
		silent,
	},
	{
		v,
		"tr",
		function()
			local utils = require("rockerboo.utils")
			local x = utils.get_visual()
			vim.cmd("sp")
			vim.cmd(
				'term cd /home/rockerboo/code/others/VALL-E-X && source /home/rockerboo/code/others/VALL-E-X/.env && python /home/rockerboo/code/others/VALL-E-X/test.py --text "'
					.. table.concat(x, " ")
					.. '" && audio-player -v 0.2 /home/rockerboo/code/others/VALL-E-X/completed-compiling.wav'
			)
		end,
		silent,
	},
	{
		n,
		"<leader>ss",
		function()
			local datetime = vim.fn.strftime("%Y-%m-%d-%H%M%S")
			vim.system({
				"cp",
				"/home/rockerboo/code/others/VALL-E-X/completed-compiling.wav",
				"/home/rockerboo/code/others/VALL-E-X/long/" .. datetime .. ".wav",
			})
		end,
		silent,
	},

	-- { n, "<leader>rr", "<cmd>:sp<CR>:term node %<CR>", silent },
	{ n, "<leader>ra", "<cmd>:sp<CR>:term accelerate launch %<CR>", silent },
}

-- Mappings
mappings.setup = function()
	-- Apply the keymaps
	require("rockerboo.utils").keymaps(maps)
end

return mappings
