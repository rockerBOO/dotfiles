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
o.completeopt = "menuone,noinsert,noselect"
o.shortmess = "c" -- Avoid showing extra messages when using completion

-- Colors
o.termguicolors = true -- Support 24bit colors

-- cmd [[ color boo ]]

-- Tmux support
g["&t_8f"] = "<Esc>[38;2;%lu;%lu;%lum]"
g["&t_8b"] = "<Esc>[48;2;%lu;%lu;%lum]"

-- Plugins (need to move out of here)
g.loaded_netrwPlugin = 1 -- Don't load netrw
g.ale_disable_lsp = 1 -- Disable Ale LSP support

g.mix_format_on_save = 1 -- Elixir mix format on save
g.rustfmt_autosave = 1 -- rustfmt on save

-- cmd [[ augroup LuaFormat ]]
-- cmd [[ autocmd! ]]
-- cmd [[ autocmd FileType lua nnoremap <buffer> <c-k> :call LuaFormat()<cr> ]]
-- cmd [[ autocmd BufWrite *.lua call LuaFormat() ]]
-- cmd [[ augroup END ]]

-- Highlight yank'd text after yankin'
cmd([[ augroup YankHighlight ]])
cmd([[  autocmd! ]])
cmd([[  autocmd TextYankPost *  lua vim.highlight.on_yank {higroup="IncSearch", timeout=1000} ]])
cmd([[ augroup END ]])

-- Reload module after saving
-- cmd [[ augroup Reload ]]
-- cmd [[  au! ]]
-- cmd [[  au BufWritePost ~/.config/nvim/init.lua <cmd>lua require'plenary.reload'.reload_module('init') ]]
-- cmd [[ augroup end ]]

-- Setup key mappings
require("mappings").setup()

-- Setup all the plugins
require("plugins").setup()

-- Configure plugins
require("setup")

-- Colorscheme
require("boo-colorscheme").use({})
