set nocompatible
set grepprg=ack
set grepformat=%f:%l:%m

call pathogen#runtime_append_all_bundles()

" ---------------------------------
" Helpers
" ---------------------------------

" Toggles options
function! MapToggle(key, opt)
  let cmd = ':set '.a:opt.'! \| set '.a:opt."?\<CR>"
  exec 'nnoremap '.a:key.' '.cmd
  exec 'inoremap '.a:key." \<C-O>".cmd
endfunction
command! -nargs=+ MapToggle call MapToggle(<f-args>)

" Open url on the current line in browser
function! Browser()
    let line0 = getline(".")
    let line = matchstr(line0, "http[^ )]*")
    let line = escape(line, "#?&;|%")
    exec ':silent !open ' . "\"" . line . "\""
endfunction

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

" Quickly switch between .h and .m files
function! Switch()
  if expand('%:e') == 'h'
    try | find %:t:r.m 
    catch
      try | find %:t:r.c
      catch
        try | find %:t:r.cc
        catch
          try | find %:t:r.cpp | catch | endtry
        endtry
      endtry
    endtry
  else
    find %:t:r.h
  endif
endfunction
command! Switch call Switch()


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

  function! ToggleBackground()
      if (g:solarized_style=="dark")
      let g:solarized_style="light"
      colorscheme solarized
  else
      let g:solarized_style="dark"
      colorscheme solarized
  endif
  endfunction
  command! ToggleBackground call ToggleBackground()
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
set virtualedit=block


" ---------------------------------
" Completion
" ---------------------------------

set completeopt=longest,menu
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*
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

" fuzzyfinder
map <leader>F :FufFile<CR>
map <leader>/ :FufFile **/<CR>
map <leader>f :FufFileWithCurrentBufferDir<CR>
map <leader>d :FufDir<CR>
map <leader>b :FufBuffer<CR>
 
nnoremap Y y$

" open a url on the current line in browser
map ,w :call Browser()<CR>

map <C-U> :DockSend<CR>

" todo
map ,a o<ESC>:r!date +'\%A, \%B \%d, \%Y'<CR>:r!date +'\%A, \%B \%d, \%Y' \| sed 's/./-/g'<CR>A<CR><ESC>
map ,o o[ ] 
map ,O O[ ] 
map ,x :s/^\[ \]/[x]/<CR>
map ,X :s/^\[x\]/[ ]/<CR>

" Ex Mode is annoying. 
" Use this for formatting instead.
map Q gq

" Save even if we forgot to open the file with sudo
cmap w!! %!sudo tee > /dev/null %

" ---------------------------------
" Plugins
" ---------------------------------

let g:fuf_file_exclude = '\v\.DS_Store|\.bak|\.swp'


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

autocmd Filetype javascript,php,sh,bash,zsh set ts=4 sts=4 sw=4 expandtab

" don't use cindent for javascript
autocmd FileType javascript setlocal nocindent

" lint files
:autocmd FileType php noremap <C-L> :!php -l %<CR>
:autocmd FileType javascript noremap <C-L> :!jsl -nocontext -nologo -process %<CR>


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
