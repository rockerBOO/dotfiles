" nvim-cmp
"
autocmd FileType TelescopePrompt lua require'cmp'.setup.buffer {
\   completion = { autocomplete = false }
\ }

autocmd FileType TelescopePrompt lua require'cmp_tabnine.config'.setup {
\    max_lines = 0
\    max_num_results = 0
\ }
