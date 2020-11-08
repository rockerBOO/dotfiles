" diagnostic-nvim

" let g:diagnostic_enable_virtual_text = 1
" let g:diagnostic_auto_popup_while_jump = 1

" nnoremap <Leader>? :OpenDiagnostic<CR>
nnoremap <Leader>k <cmd>lua vim.lsp.diagnostic.goto_prev()<CR>
nnoremap <Leader>j <cmd>lua vim.lsp.diagnostic.goto_next()<CR>

