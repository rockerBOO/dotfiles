augroup LSPCursor
	autocmd!
	" autocmd CursorHold,CursorHoldI <buffer> :lua vim.lsp.buf.hover()
augroup END

" Setup default LSP keybinds
" MOVED TO lua/mappings.lua
" nnoremap <silent> gd         <cmd>lua vim.lsp.buf.definition()<CR>
" nnoremap <silent> K          <cmd>lua vim.lsp.buf.hover()<CR>
" nnoremap <silent> gD         <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> 1gD        <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> gr         <cmd>lua require'telescope.builtin'.lsp_references{}<CR>
" nnoremap <silent> g0         <cmd>lua vim.lsp.buf.document_symbol()<CR>
" nnoremap <silent> gW         <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
" nnoremap <silent> <Leader>re <cmd>lua vim.lsp.buf.rename()<CR>
" nnoremap <silent> <Leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>
" nnoremap <silent> <c-]>      <cmd>lua vim.lsp.buf.declaration()<CR>


" nnoremap <silent> <Leader>di <cmd>lua vim.lsp.util.show_line_diagnostics()<CR>
