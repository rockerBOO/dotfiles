nnoremap <Leader>r :Dispatch cargo run --bin plant_game<CR>
nnoremap <Leader>t :Dispatch cargo test<CR>

augroup ShowInlayHints
  autocmd!
  " autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true, prefix = ' ░ ', highlight = "Menu" }
  autocmd InsertLeave,BufEnter,BufCreate,BufWinEnter,TabEnter,BufWritePost FileType rust :lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "NonText" }
augroup end

