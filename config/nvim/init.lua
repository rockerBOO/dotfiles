local g = vim.g
local opt = vim.o
local cmd = vim.cmd

g.mapleader = " "

-- opt.noshowmode = true -- No show modes twice with status bar

opt.splitbelow = true -- Default split below
opt.splitright = true -- Default split right

opt.laststatus = 2
opt.ff = "unix"

-- Files
opt.hidden = true
-- opt.nobackup = true
-- opt.nowritebackup = true
-- opt.noswapfile = true

cmd [[ augroup YankHighlight ]]
cmd [[ autocmd! ]]
cmd [[ autocmd TextYankPost *  lua vim.highlight.on_yank {higroup="IncSearch", timeout=1000} ]]
cmd [[ augroup END ]]

cmd [[ augroup Reload ]]
cmd [[  au! ]]
cmd [[  au BufWritePost ~/.config/nvim/init.lua <cmd>lua require'plenary.reload'.reload_module'init'<cr> ]]
cmd [[ augroup end ]]

-- Tabs
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 2
-- opt.noexpandtab = true

opt.termguicolors = true -- Support 24bit colors

opt.clipboard = "unnamedplus"

opt.scrolloff = 10

opt.emoji = true

-- Completion
opt.completeopt = "menuone,noinsert,noselect"

opt.shortmess = "c" -- Avoid showing extra messages when using completion

g["&t_8f"] = "<Esc>[38;2;%lu;%lu;%lum]"
g["&t_8b"] = "<Esc>[48;2;%lu;%lu;%lum]"

-- Plugins (need to move out of here)
g.ale_disable_lsp = 1 -- Disable Ale LSP support

g.mix_format_on_save = 1 -- Elixir mix format on save
g.rustfmt_autosave = 1 -- rustfmt on save

-- cmd [[ color boo ]]

-- Mappings
local setup_mappings = function()
  local n, i = "n", "i"

  local maps = {
    {n, "<C-l>", "<C-w>l"},
    {n, "<C-h>", "<C-w>h"},
    {n, "<C-j>", "<C-w>j"},
    {n, "<C-k>", "<C-w>k"},

    {i, "jk", "<esc>"},
    {i, "JK", "<esc>"},
    {i, "Jk", "<esc>"},
    {i, "jK", "<esc>"},

    {i, "hj", "<esc>"},
    {i, "HJ", "<esc>"},
    {i, "Hj", "<esc>"},
    {i, "hJ", "<esc>"},

    {i, "kl", "<esc>"},
    {i, "KL", "<esc>"},
    {i, "Kl", "<esc>"},
    {i, "kL", "<esc>"},

    {i, "<Up>", "<nop>"},
    {i, "<Down>", "<nop>"},

    {n, "<Leader>w", ":w<cr>"},
    {n, "<Leader>q", ":q<cr>"},

    {i, "<C-l>", "A<cr>"},

    {i, "<expr>", "<Tab> pumvisible() ? '<C-n>' : '<Tab>'"},
    {i, "<expr>", "<S-Tab> pumvisible() ? '<C-p>' : '<S-Tab>'"},

    {n, "<Leader>gh", "<cmd>TShighlightCapturesUnderCursor"},
  }

  for _, m in ipairs(maps) do require'rockerboo.utils'.keymap(m) end
end

setup_mappings()

-- Setup all the plugins
require"plugins".setup()
require "setup"
require"boo-colorscheme".use {}
