" telescope.nvim
" ---
" let g:telescope_cache_results = 1 

" Open this file in a new tab
nnoremap <Leader>en <cmd>lua require'telescope.builtin'.find_files{ cwd = "~/.config/nvim" }<CR>

lua <<EOF
function PlenaryReload()
  require('plenary.reload').reload_module("telescope.themes")
  require('plenary.reload').reload_module("telescope")
  require('plenary.reload').reload_module("plenary")
  require'plenary.reload'.reload_module('boo-colorscheme')
  require'plenary.reload'.reload_module('plugin')
  require'plenary.reload'.reload_module('lsp_extensions')
  require'boo-colorscheme'.use{}
end
EOF

" Reload module using plenary
nnoremap <Leader>asdf :lua PlenaryReload()<CR>

" Telescope binds 
nnoremap <Leader>f <cmd>lua FindFiles()<CR>
nnoremap <Leader>gf :lua require'telescope.builtin'.git_files(require'telescope.themes'.get_dropdown())<CR>
nnoremap <Leader>gg :lua require'telescope.builtin'.find_files{ cwd = "~/.config/nvim/plugged" }<CR>

" LSP
nnoremap ggr :lua LspWorkspaceSymbols()<CR>
nnoremap <Leader>P :lua require'telescope.builtin'.planets{}<CR>

" Grep files
nnoremap <Leader>gl :lua require'telescope.builtin'.live_grep{}<CR>

