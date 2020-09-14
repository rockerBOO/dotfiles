nnoremap <Leader>r :Dispatch cargo run --bin plant_game<CR>
nnoremap <Leader>t :Dispatch cargo test<CR>
lua <<EOF
function LSPExtensionsInlayHints()
  require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "NonText" }
end

function LSPFormat(opts)
  return vim.lsp.buf.formatting_sync(opts, 1000)
end
EOF
" autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true, prefix = ' ░ ', highlight = "Menu" }
autocmd InsertLeave,BufEnter,BufCreate,BufWinEnter,TabEnter,BufWritePost lua LSPExtensionsInlayHints<CR> 
autocmd BufWritePre lua LSPFormatRust()
