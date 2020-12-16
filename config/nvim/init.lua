--[[
--  Hello
--]]

local g, opt, cmd = vim.g, vim.o, vim.cmd

g.mapleader = " "

opt.splitbelow = true -- Default split below
opt.splitright = true -- Default split right

opt.laststatus = 2
opt.ff = "unix"

-- No show modes twice with status bar
cmd [[ set noshowmode ]]

-- Files
opt.hidden = true
cmd [[ 
set noswapfile
set nobackup
set nowritebackup 
]]

-- Tabs
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
cmd [[
set noexpandtab
]]

opt.termguicolors = true -- Support 24bit colors
opt.clipboard = "unnamedplus"
opt.scrolloff = 10 -- Leave 10 rows when scrolling
opt.emoji = true -- Use emojis

-- Completion
opt.completeopt = "menuone,noinsert,noselect"
opt.shortmess = "c" -- Avoid showing extra messages when using completion

-- Tmux support
g["&t_8f"] = "<Esc>[38;2;%lu;%lu;%lum]"
g["&t_8b"] = "<Esc>[48;2;%lu;%lu;%lum]"

-- Plugins (need to move out of here)
g.loaded_netrwPlugin = 1 -- Don't load netrw
g.ale_disable_lsp = 1 -- Disable Ale LSP support

g.mix_format_on_save = 1 -- Elixir mix format on save
g.rustfmt_autosave = 1 -- rustfmt on save

-- cmd [[ color boo ]]

-- Reload module after saving
cmd [[ augroup YankHighlight ]]
cmd [[  autocmd! ]]
cmd [[  autocmd TextYankPost *  lua vim.highlight.on_yank {higroup="IncSearch", timeout=1000} ]]
cmd [[ augroup END ]]

-- Reload module after saving
cmd [[ augroup Reload ]]
cmd [[  au! ]]
cmd [[  au BufWritePost ~/.config/nvim/init.lua <cmd>lua require'plenary.reload'.reload_module'init'<cr> ]]
cmd [[ augroup end ]]

-- Setup all the plugins
require"plugins".setup()
require"mappings".setup()

require "setup"
require"boo-colorscheme".use {}
