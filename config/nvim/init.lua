--
--     Hello
--
local g, o, cmd = vim.g, vim.o, vim.cmd
local b = vim.b

g.mapleader = " "

o.splitbelow = true -- Default split below
o.splitright = true -- Default split right

o.showmatch = true

-- Compositor transparency on pum menus
o.pumblend = 10

o.laststatus = 2
o.ff = "unix"

-- No show modes twice with status bar
b.showmode = false
-- cmd [[ set noshowmode ]]

-- Files
-- if you had like noswapfile you should use o.swapfile = false
-- simular throughout for when you had `set noswapfile`
o.hidden = true
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

-- Tmux support
g["&t_8f"] = "<Esc>[38;2;%lu;%lu;%lum]"
g["&t_8b"] = "<Esc>[48;2;%lu;%lu;%lum]"

-- Plugins
-- g.loaded_netrwPlugin = 1 -- Don't load netrw

-- Highlight yank'd text after yankin'
cmd([[ augroup YankHighlight ]])
cmd([[  autocmd! ]])
cmd([[  autocmd TextYankPost *  lua vim.highlight.on_yank {higroup="IncSearch", timeout=1000} ]])
cmd([[ augroup END ]])

-- Reload module after saving
-- cmd([[ augroup Reload ]])
-- cmd([[  au! ]])
-- cmd([[  au BufWritePost ~/.config/nvim/init.lua <cmd>lua require'plenary.reload'.reload_module('init')<cr> ]])
-- cmd([[ augroup end ]])

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
	require("boo-colorscheme").use({})
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
