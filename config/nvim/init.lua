--
--     Hello
--
local g, o, cmd, opt = vim.g, vim.o, vim.cmd, vim.opt

g.mapleader = " "

o.splitbelow = true -- Default split below
o.splitright = true -- Default split right

o.showmatch = true

-- Compositor transparency on pum menus
o.pumblend = 10

o.laststatus = 2
o.ff = "unix"

-- No show modes twice with status bar
o.showmode = false
-- cmd [[ set noshowmode ]]

-- Files
o.hidden = true
-- if you had like noswapfile you should use o.swapfile = false
-- simular throughout for when you had `set noswapfile`
o.swapfile = false
o.backup = false
o.writebackup = false

-- Lower update time for CursorHold event
o.updatetime = 1000

-- Undo
o.undodir = vim.fn.expand("~/.config/nvim/undo")
o.undofile = true

-- Shada
o.shada = "!,'1000,<50,s10,h"

-- Tabs
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 2
o.expandtab = false

o.clipboard = "unnamedplus"
o.scrolloff = 10 -- Leave 10 rows when scrolling
o.emoji = true -- Use emojis

o.formatoptions = "cqrnj"

-- Completion
-- o.completeopt = "menuone,noinsert,noselect"
o.completeopt = "menu,menuone,noselect"
o.shortmess = "filnxtToOFc" -- Avoid showing extra messages when using completion

-- Colors
o.termguicolors = true -- Support 24bit colors

opt.lcs = "tab:>-,eol:<,nbsp:%,space:."

-- Tmux support
g["&t_8f"] = "<Esc>[38;2;%lu;%lu;%lum]"
g["&t_8b"] = "<Esc>[48;2;%lu;%lu;%lum]"

-- Plugins
-- g.loaded_netrwPlugin = 1 -- Don't load netrw

-- Highlight yank'd text after yankin'
vim.api.nvim_define_augroup({ name = "YankHighlight", clear = true })
vim.api.nvim_define_autocmd({
	group = "YankHighlight",
	event = "TextYankPost",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 1000 })
	end,
})

-- Reload module after saving
vim.api.nvim_define_augroup({ name = "ReloadNeovim", clear = true })
vim.api.nvim_define_autocmd({
	group = "ReloadNeovim",
	event = "BufWritePost",
	pattern = "/home/rockerboo/.config/nvim/./init.lua",
	callback = function()
		print("hello")
		require("plenary.reload").reload_module("init")
	end,
})

-- Reload module
function Reload(module)
	require("plenary.reload").reload_module(module)
end

-- Require shortcut
function R(module)
	return require(module)
end

function PlenaryReload()
	local reload = require("plenary.reload").reload_module
	-- require("plenary.reload").reload_module("telescope")
	-- require("plenary.reload").reload_module("plenary")
	-- require("plenary.reload").reload_module("lsp_extensions")
	reload("boo-colorscheme")
	reload("plugin")
	reload("rockerboo")
	require("telescope.mappings").setup()
	require("boo-colorscheme").use()
end

-- Setup all the plugins
require("plugins").setup()

-- Setup key mappings
require("mappings").setup()

-- Configure plugins
require("setup").setup()

-- Colorscheme
-- require("boo-colorscheme").use({})
-- o.colorscheme = "boo"
cmd([[ colorscheme boo ]])
