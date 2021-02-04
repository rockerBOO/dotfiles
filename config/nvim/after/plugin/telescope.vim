" telescope.nvim
" ---
" let g:telescope_cache_results = 1 

" Open this file in a new tab
nnoremap <Leader>en <cmd>lua require'plugin.telescope'.find_files{ cwd = "~/.config/nvim" }<CR>

lua <<EOF
EOF


" Reload module using plenary
nnoremap <Leader>asdf :lua PlenaryReload()<CR>

" Telescope binds 
nnoremap <Leader>f <cmd>lua require'plugin.telescope'.find_files()<CR>
nnoremap <Leader>gf :lua require'telescope.builtin'.git_files(require'telescope.themes'.get_dropdown())<CR>
nnoremap <Leader>gg :lua require'plugin.telescope'.find_files_plugins()<CR>

nnoremap <Leader>gt :lua require'telescope.builtin'.treesitter(require'telescope.themes'.get_dropdown())<CR>

" LSP
nnoremap ggr :lua LspWorkspaceSymbols()<CR>
nnoremap <Leader>P :lua require'telescope.builtin'.planets{}<CR>

" Grep files
nnoremap <Leader>gl :lua require'telescope.builtin'.live_grep{}<CR>

