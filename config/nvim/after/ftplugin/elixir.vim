set path=.,lib/**,test/**

nnoremap <Leader>r :Dispatch mix run<CR> 
" nnoremap <Leader>t :Dispatch mix test<CR>

setlocal shiftwidth=2 softtabstop=2 expandtab iskeyword+=!,?
setlocal comments=:#
setlocal commentstring=#\ %s

setlocal suffixesadd=.ex,.exs,.eex,.leex,.sface,.erl,.xrl,.yrl,.hrl
