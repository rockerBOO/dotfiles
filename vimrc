set nocompatible
call pathogen#runtime_append_all_bundles()

" ---------------------------------
" UI
" ---------------------------------

syntax on
set title
set number
set nolist
set listchars=tab:▸\ ,eol:¬,extends:❯,precedes:❮
set visualbell t_vb=
set mouse=a
set showcmd
set showmode
set ch=1
set grepprg=ack
set grepformat=%f:%l:%m
set binary
set autoindent
set smartindent
set smarttab
set guicursor=a:blinkon0
set nowrap
set backspace=indent,eol,start
set nospell
set linespace=0
set tabstop=4 
set shiftwidth=2
set softtabstop=2
set shiftround
set expandtab
set nosmarttab
set formatoptions+=n
set virtualedit=block
set isk+=_,$,@,%,#,-
set encoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1,default
set ignorecase
set smartcase
set hlsearch
set incsearch
set gdefault
set foldenable
set nostartofline
set scrolljump=5
set scrolloff=3
set showmatch
set splitbelow
set splitright

" highlight VCS conflicts
match ErrorMsg '^\(<\|=\|>\)\{7\}\([^=].\+\)\?$'


let g:rails_statusline=0

set fo-=r

if has("gui_running")
  set background=dark
  set guioptions=egmrt
  set guifont=Monaco:h14
  colorscheme solarized

  set lines=40 columns=120

  set go-=T
  set go-=r
endif

" resize splits when window is resized
au VimResized * exe "normal! \<c-w>="


" ---------------------------------
" Completion
" ---------------------------------

set completeopt=longest,menuone,preview
set wildmode=list:longest,list:full

set wildignore+=.hg,.git,.svn
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.pyc
set wildignore+=*.sw?
set wildignore+=.DS_Store

set wildmenu
set complete=.,t
"set wildignore=*~


" ---------------------------------
" Buffers
" ---------------------------------

set hidden
set nobackup
set nowritebackup
set noswapfile

if has("undofile")
  set undofile
  set undodir=~/.undo
end


" ---------------------------------
" Mappings
" ---------------------------------

let mapleader = ","
nnoremap ; :

" code folding
nmap <leader>f0 :set foldlevel=0<CR>
nmap <leader>f1 :set foldlevel=1<CR>
nmap <leader>f2 :set foldlevel=2<CR>
nmap <leader>f3 :set foldlevel=3<CR>
nmap <leader>f4 :set foldlevel=4<CR>
nmap <leader>f5 :set foldlevel=5<CR>
nmap <leader>f6 :set foldlevel=6<CR>
nmap <leader>f7 :set foldlevel=7<CR>
nmap <leader>f8 :set foldlevel=8<CR>
nmap <leader>f9 :set foldlevel=9<CR>

" cd to current file's directory
nmap <leader>cd %:p:h

" feature toggles
function! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)

MapToggle <F1> hlsearch
MapToggle <F2> wrap
MapToggle <F3> number
MapToggle <F4> paste

" new line creation with return
map <S-Enter> O<ESC>
map <Enter> o<ESC>

" indentation
vnoremap < <gv
vnoremap > >gv

" window splitting
nmap <leader>swh :topleft vnew<CR>
nmap <leader>swl :botright vnew<CR>
nmap <leader>swk :topleft new<CR>
nmap <leader>swj :botright new<CR>
nmap <leader>sh :leftabove vnew<CR>
nmap <leader>sl :rightbelow vnew<CR>
nmap <leader>sk :leftabove new<CR>
nmap <leader>sj :rightbelow new<CR>

" window movement
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-q> <C-w>q

map <leader>/ :CtrlP<CR>
map <leader>b :CtrlPBuffer<CR> 
map <leader>h :CtrlPMRU<CR> 
 
nnoremap Y y$

map <C-U> :DockSend<CR>

" insert mode completion
inoremap <C-L> <C-X><C-L>
inoremap <C-F> <C-X><C-F>

" quick access to ack
map <leader>a :Ack

" Ex Mode is annoying. 
" Use this for formatting instead.
map Q gq

" Save even if we forgot to open the file with sudo
cmap w!! %!sudo tee > /dev/null %

" Close inactive (hidden) buffers
" http://stackoverflow.com/questions/2974192/how-can-i-pare-down-vims-buffer-list-to-only-include-active-buffers
" http://stackoverflow.com/questions/1534835/how-do-i-close-all-buffers-that-arent-shown-in-a-window-in-vim
function! CloseHiddenBuffers()
  " figure out which buffers are visible in any tab
  let visible = {}
  for t in range(1, tabpagenr('$'))
    for b in tabpagebuflist(t)
      let visible[b] = 1
    endfor
  endfor
  " close any buffer that are loaded and not visible
  let l:tally = 0
  for b in range(1, bufnr('$'))
    if bufloaded(b) && !has_key(visible, b)
      let l:tally += 1
      exe 'bw ' . b
    endif
  endfor
  echon "Deleted " . l:tally . " buffers"
endfunction
command! -nargs=* Only call CloseHiddenBuffers()

" quick access to running shell commands
function! s:ExecuteInShell(command) " {{{
    let command = join(map(split(a:command), 'expand(v:val)'))
    let winnr = bufwinnr('^' . command . '$')
    silent! execute  winnr < 0 ? 'botright vnew ' . fnameescape(command) : winnr . 'wincmd w'
    setlocal buftype=nowrite bufhidden=wipe nobuflisted noswapfile nowrap nonumber
    echo 'Execute ' . command . '...'
    silent! execute 'silent %!'. command
    silent! redraw
    silent! execute 'au BufUnload <buffer> execute bufwinnr(' . bufnr('#') . ') . ''wincmd w'''
    silent! execute 'nnoremap <silent> <buffer> <LocalLeader>r :call <SID>ExecuteInShell(''' . command . ''')<CR>:AnsiEsc<CR>'
    silent! execute 'nnoremap <silent> <buffer> q :q<CR>'
    silent! execute 'AnsiEsc'
    echo 'Shell command ' . command . ' executed.'
endfunction " }}}
command! -complete=shellcmd -nargs=+ Shell call s:ExecuteInShell(<q-args>)
nnoremap <leader>! :Shell 

" ---------------------------------
" Plugins
" ---------------------------------

let g:fuf_file_exclude = '\v\.DS_Store|\.bak|\.swp'
let g:statline_show_encoding = 0

let g:syntastic_enable_signs = 1
let g:syntastic_disabled_filetypes = ['html']

" ---------------------------------
" Auto Commands
" ---------------------------------

" set filetype
autocmd BufRead *.css.php set filetype=css
autocmd BufRead *.less set filetype=css
autocmd BufRead *.js.php set filetype=javascript
autocmd BufRead *.jsx set filetype=javascript
autocmd BufRead *.mkd set filetype=mkd
autocmd BufRead *.markdown set filetype=mkd
autocmd BufRead *.god set filetype=ruby
autocmd BufRead *.as set filetype=actionscript

" set completion
autocmd FileType ruby set omnifunc=rubycomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType xml set omnifunc=xmlcomplete#CompleteTags
autocmd FileType php set omnifunc=phpcomplete#CompletePHP
autocmd FileType c set omnifunc=ccomplete#Complete

autocmd Filetype gitcommit set tw=68 spell

autocmd Filetype python,javascript,php,sh,bash,zsh set ts=4 sts=4 sw=4 expandtab

" don't use cindent for javascript
autocmd FileType javascript setlocal nocindent

autocmd FileType php set keywordprg=pman
autocmd FileType php set iskeyword-=-

" ---------------------------------
" OS X Stuff
" ---------------------------------

if system('uname') =~ 'Darwin'
  let $PATH = $HOME .
    \ '/usr/local/bin:/usr/local/sbin:' .
    \ '/usr/pkg/bin:' .
    \ '/opt/local/bin:/opt/local/sbin:' .
    \ $PATH
endif
