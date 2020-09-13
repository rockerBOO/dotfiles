augroup LuaFormatter
	autocmd!
	autocmd FileType lua nnoremap <buffer> <c-k> :call LuaFormat()<cr>
  "autocmd BufWrite *.lua call LuaFormat()
augroup end


