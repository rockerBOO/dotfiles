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

o.laststatus = 3 -- only show 1 statusbar
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

o.signcolumn = "yes:1"

o.formatoptions = "cqrnj"

-- Completion
-- o.completeopt = "menuone,noinsert,noselect"
o.completeopt = "menu,menuone,noselect"
o.shortmess = "filnxtToOFc" -- Avoid showing extra messages when using completion

-- Colors
o.termguicolors = true -- Support 24bit colors

opt.lcs = "tab:>-,eol:<,nbsp:%,space:."

-- diff
opt.diffopt = {
	"internal",
	"filler",
	"closeoff",
	"hiddenoff",
	"algorithm:minimal",
}

-- Tmux support
g["&t_8f"] = "<Esc>[38;2;%lu;%lu;%lum]"
g["&t_8b"] = "<Esc>[48;2;%lu;%lu;%lum]"

-- Plugins
-- g.loaded_netrwPlugin = 1 -- Don't load netrw

-- Highlight yank'd text after yankin'
vim.api.nvim_create_augroup("YankHighlight", {})
vim.api.nvim_create_autocmd("TextYankPost", {
	group = "YankHighlight",
	callback = function()
		vim.highlight.on_yank({ higroup = "IncSearch", timeout = 1000 })
	end,
})

-- Reload module after saving
vim.api.nvim_create_augroup("ReloadNeovim", {})
vim.api.nvim_create_autocmd("BufWritePost", {
	group = "ReloadNeovim",
	pattern = "~//.config/nvim/./init.lua",
	callback = function()
		print("hello")
		require("plenary.reload").reload_module("init")
	end,
})

function R(module)
	return require(module)
end

-- Setup all the plugins
require("plugins").setup()

-- Setup key mappings
require("mappings").setup()

-- Configure plugins
require("setup").setup()

-- Colorscheme
-- require("boo-colorscheme").use({ theme = 'radioactive' })
-- o.colorscheme = "boo"
-- vim.g.boo_colorscheme_theme = "radioactive"
cmd([[ colorscheme boo ]])
