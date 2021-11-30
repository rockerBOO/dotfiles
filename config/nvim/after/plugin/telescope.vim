" telescope.nvim
" ---
" let g:telescope_cache_results = 1 

" Open this file in a new tab
nnoremap <Leader>en <cmd>lua require'plugin.telescope'.find_files{ cwd = "~/.config/nvim" }<CR>
nnoremap <Leader>eN <cmd>lua require'telescope.builtin'.live_grep{ cwd = "~/.config/nvim" }<CR>

" Telescope binds 
nnoremap <Leader>gf :lua require'telescope.builtin'.git_files(require'telescope.themes'.get_dropdown())<CR>
nnoremap <Leader>gg :lua require'plugin.telescope'.find_files_plugins()<CR>

nnoremap <Leader>gt :lua require'telescope.builtin'.treesitter(require'telescope.themes'.get_dropdown())<CR>

nnoremap gW :lua require'telescope.builtin'.lsp_workspace_symbols(require'telescope.themes'.get_dropdown())<CR>
nnoremap g0 :lua require'telescope.builtin'.lsp_document_symbols(require'telescope.themes'.get_dropdown())<CR>

" LSP

" Grep files
nnoremap <Leader>gl :lua require'telescope.builtin'.live_grep{}<CR>

