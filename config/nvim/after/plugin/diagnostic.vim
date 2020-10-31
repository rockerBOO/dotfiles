" diagnostic-nvim

" let g:diagnostic_enable_virtual_text = 1
" let g:diagnostic_auto_popup_while_jump = 1

" nnoremap <Leader>? :OpenDiagnostic<CR>
nnoremap <Leader>k <cmd>lua vim.lsp.diagnostic.buf_move_prev_diagnostic()<CR>
nnoremap <Leader>j <cmd>lua vim.lsp.diagnostic.buf_move_next_diagnostic()<CR>

