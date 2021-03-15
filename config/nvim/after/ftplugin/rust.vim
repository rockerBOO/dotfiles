augroup InlayHints
  autocmd!
  autocmd InsertLeave,BufEnter,BufCreate,BufWinEnter,TabEnter,BufWritePost  lua require'lsp_extensions'.inlay_hints() 
augroup END

