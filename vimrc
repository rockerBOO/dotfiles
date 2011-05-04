set nocompatible

call pathogen#runtime_append_all_bundles()

" ---------------------------------
" Helpers
" ---------------------------------

function! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)

function! Browser()
    let line0 = getline(".")
    let line = matchstr(line0, "http[^ )]*")
    let line = escape(line, "#?&;|%")
    exec ':silent !open ' . "\"" . line . "\""
endfunction

" ---------------------------------
" UI
" ---------------------------------

syntax on
set number
set guicursor=a:blinkon0
set visualbell t_vb=
set nospell
set nostartofline
set mouse=a
set backspace=indent,eol,start
set laststatus=2
set ch=2
set ruler
set rulerformat=%25(%n%m%r:\ %Y\ [%l,%v]\ %p%%%)
let g:rails_statusline=0

set fo-=r

set encoding=utf-8
set fileencodings=ucs-bom,utf-8,latin1,default

set isk+=_,$,@,%,#,-
set listchars=tab:▸\ ,eol:¬

if has("gui_running")
  set background=dark
  set guioptions=egmrt
  set guifont=Dejavu_Sans_Mono:h14
  colorscheme solarized

  set lines=40 columns=120

  set go-=T
  set go-=r
endif


" ---------------------------------
" Text Formatting
" ---------------------------------

set autoindent
set smartindent
set smarttab
set nowrap
set tabstop=4 
set shiftwidth=2
set softtabstop=2
set expandtab
set nosmarttab
set formatoptions+=n
set textwidth=80
set virtualedit=block


" ---------------------------------
" Completion
" ---------------------------------

set completeopt=longest,menu
set wildmode=list:longest,list:full
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
set undofile
set undodir=~/.undo


" ---------------------------------
" Visual Cues
" ---------------------------------

set ignorecase
set hlsearch
set incsearch
set showmatch
set mat=5


" ---------------------------------
" Mappings
" ---------------------------------

let mapleader = ","

" feature toggles
MapToggle <F1> hlsearch
MapToggle <F2> wrap
MapToggle <F3> number

" new line creation with return
map <S-Enter> O<ESC>
map <Enter> o<ESC>

" indentation
:vnoremap < <gv
:vnoremap > >gv

" window splitting
nmap <leader>swh  :topleft  vnew<CR>
nmap <leader>swl :botright vnew<CR>
nmap <leader>swk    :topleft  new<CR>
nmap <leader>swj  :botright new<CR>
nmap <leader>sh   :leftabove  vnew<CR>
nmap <leader>sl  :rightbelow vnew<CR>
nmap <leader>sk     :leftabove  new<CR>
nmap <leader>sj   :rightbelow new<CR>

" window movement
map <C-h> <C-w>h
map <C-l> <C-w>l
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-q> <C-w>q

" fuzzyfinder
map <leader>F :FufFile<CR>
map <leader>/ :FufFile **/<CR>
map <leader>f :FufFileWithCurrentBufferDir<CR>
map <leader>d :FufDir<CR>
map <leader>b :FufBuffer<CR>
 
nnoremap Y y$

" open a url on the current line in browser
map ,w :call Browser()<CR>

" todo
map ,a o<ESC>:r!date +'\%A, \%B \%d, \%Y'<CR>:r!date +'\%A, \%B \%d, \%Y' \| sed 's/./-/g'<CR>A<CR><ESC>
map ,o o[ ] 
map ,O O[ ] 
map ,x :s/^\[ \]/[x]/<CR>
map ,X :s/^\[x\]/[ ]/<CR>

" ---------------------------------
" Plugins
" ---------------------------------

let g:fuf_file_exclude = '\v\.DS_Store|\.bak|\.swp'


" ---------------------------------
" Auto Commands
" ---------------------------------

" set filetype
autocmd FileType html set filetype=xhtml
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
autocmd Filetype ruby set tw=80 ts=2

autocmd Filetype sh,bash,zsh set ts=4 sts=4 sw=4 expandtab

" don't use cindent for javascript
autocmd FileType javascript setlocal nocindent


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
