" telescope.nvim
" ---


" Open this file in a new tab
nnoremap <Leader>en <cmd>lua require'telescope.builtin'.find_files{ cwd = "~/.config/nvim" }<CR>

" Reload module using plenary
nnoremap <Leader>asdf :lua require('plenary.reload').reload_module("telescope")<CR>

" Telescope binds 
" nnoremap <Leader>f <cmd>:lua require'telescope.builtin'.find_files()<CR>
nnoremap <Leader>f <cmd>:lua require'telescope.builtin'.find_files({ sorting_strategy = "ascending", preview_cutoff = 200,border = false, layout_strategy = "dropdown", prompt = "", width = 50,winblend = 3, results_title = "", borderchars = { '', '', '', '', '', '', '', ''} })<CR>

" augroup TelescopeBindings
"   autocmd!
"   autocmd FileType elixir,rust,javascript,typescript nnoremap ggr :lua LspWorkspaceSymbols()<CR>
" augroup end
nnoremap ggr :lua LspWorkspaceSymbols()<CR>

nnoremap <Leader>P :lua require'telescope.builtin'.planets{}<CR>

nnoremap <Leader>lg :lua LiveGrep()<CR>

