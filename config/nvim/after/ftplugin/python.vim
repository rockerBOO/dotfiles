set shiftwidth=4 tabstop=4 softtabstop=4 expandtab autoindent smartindent
setlocal colorcolumn=80

setlocal path=.,**,tests,bin/**
setlocal wildignore=*/__pycache__/*,*.pyc

nnoremap <leader>tt <cmd>sp<cr>:term pytest %<cr>
