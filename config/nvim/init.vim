let mapleader = "\<Space>"

" No show modes twice with status bar
set noshowmode

" Default split to bottom, right
set splitbelow
set splitright

set laststatus=2

set ff=unix

set wildignore+=*/.hg,*/.git,*/.svn
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg

set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest,*.pyc
set wildignore+=*.sw?
set wildignore+=.DS_Store

set wildmenu
set wildmode=longest:full,full

set hidden
set nobackup
set nowritebackup
set noswapfile

" Set tabs to 2
set tabstop=2
set shiftwidth=2
set softtabstop=2
set noexpandtab
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

if (has("termguicolors"))
	let g:nvcode_termcolors=256
  set termguicolors
  hi LineNr ctermbg=NONE guibg=NONE
endif

scriptencoding utf-16 " allow emojis

" fix the emoji spacing for old vim
set noemoji

" does not work on neovim
if !has('nvim')
  " treat emojis 😄  as full width characters
  set emoji
end


" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

" Handle tmux properly
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Disable ale
let g:ale_disable_lsp = 1

" let g:ale_fixers = {
" \   '*': ['remove_trailing_lines', 'trim_whitespace'],
" \   'javascript': ['prettier', 'eslint'],
" \}

" mix format
let g:mix_format_on_save = 1

" rustfmt
let g:rustfmt_autosave = 1

" leafgarland/typescript-vim
" let g:typescript_indent_disable = 1

" ALE
" let g:ale_fix_on_save = 1

call plug#begin()
  " Colors
  Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
  Plug 'haishanh/night-owl.vim'
  " Plug 'arcticicestudio/nord-vim', { 'on': 'NERDTreeToggle' }
  Plug 'bluz71/vim-moonfly-colors'
  Plug 'ChristianChiarulli/nvcode-color-schemes.vim'

	" Style css in styled-components
  Plug 'styled-components/vim-styled-components'

  " Configure LSP 
  Plug 'neovim/nvim-lspconfig'

  " LSP Diagnostics
  " Plunvim-lua/diagnostic-nvim'

  " LSP/Treesitter completion
  Plug 'nvim-lua/completion-nvim'

  " Completion source for buffers
  Plug 'steelsojka/completion-buffers'

  " LSP Status Bar
  Plug 'nvim-lua/lsp-status.nvim'

  " Express line (status bar)
  Plug 'tjdevries/express_line.nvim'

  " Treesitter  
  Plug 'nvim-treesitter/nvim-treesitter'

  " Completion from treesitter
  Plug 'nvim-treesitter/completion-treesitter'

  " Indent rules for python
  Plug 'vim-scripts/indentpython.vim'

  " Rust syntax rules
  Plug 'rust-lang/rust.vim'

   " Elixir syntax rules
  Plug 'elixir-editors/vim-elixir'
  " Plug 'slashmili/alchemist.vim'
  Plug 'mhinz/vim-mix-format'
  Plug 'moofish32/vim-ex_test'

  " File tree
  " Plug 'preservim/nerdtree'

  " Git commands
  Plug 'tpope/vim-fugitive'

  "Plug 'tpope/vim-sleuth'

  " Auto-complete ends
  Plug 'tpope/vim-endwise'

  " Dispatch jobs (like make, mix, yarn, tests)
  Plug 'tpope/vim-dispatch'

  " sd Sandwich for wrapping variables
  "Plug 'mchakann/vim-sandwich'
  Plug 'tpope/vim-surround'

  " Distraction-free writing 
  Plug 'junegunn/goyo.vim'

  Plug 'junegunn/limelight.vim'
  " Tooltips
  " Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

  " Comment helpers
  Plug 'tpope/vim-commentary'

  " Typescript
  Plug 'leafgarland/typescript-vim'

  " JSX/TSX syntax 
  Plug 'peitalin/vim-jsx-typescript'

  " Editorconfig support
  Plug 'editorconfig/editorconfig-vim'

  " Neovim Lua Development
  Plug 'tjdevries/nlua.nvim'

	" Colorizer
  Plug 'norcalli/nvim-colorizer.lua'

  " This is required for syntax highlighting
  Plug 'euclidianAce/BetterLua.vim'

  " LSP Extensions
  Plug 'tjdevries/lsp_extensions.nvim'

  Plug 'tjdevries/colorbuddy.nvim'

  " Some stupid thing
  Plug 'ThePrimeagen/vim-be-good',

  " ES Linting
  Plug 'dense-analysis/ale'

  Plug 'andrejlevkovitch/vim-lua-format'

  " JS/TS/HTML formatter
	Plug 'prettier/vim-prettier', {
		\ 'do': 'yarn install',
		\ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }

  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-lua/plenary.nvim'

  " Telescope fuzzy finder
  Plug 'nvim-lua/telescope.nvim'

  Plug 'kyazdani42/nvim-web-devicons'

  " Dashboard too many things I do not want right now
  " Plug 'hardcoreplayers/dashboard-nvim'

  " Nightfly colors
  Plug 'bluz71/vim-nightfly-guicolors'
  
  Plug 'hrsh7th/vim-vsnip'
  Plug 'hrsh7th/vim-vsnip-integ'

  " Fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  Plug 'justinmk/vim-dirvish'

  "Neomake
  " Plug 'neomake/neomake'
call plug#end()


lua require'init'

" Setup colors
color boo

" colors
" colorscheme snazzy

" Reload init.vim
augroup ReloadNvim 
  au!
  au BufWritePost ~/.config/nvim/init.vim :source ~/.config/nvim/init.vim
augroup end

" Keybinds
" =>>=>>=>>=>>=>>=>>=>>=>>=>>=>>

" Control panes without using <C-w>
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" Escape in insert mode 
inoremap jk <esc>

" Training new escape key
" inoremap <esc> <nop>

" Training off arrow keys
inoremap <Up> <nop>
inoremap <Down> <nop>

" Reselect visual block after indent
xnoremap  <   <gv
xnoremap  >   >gv

" <Tab> indents in visual mode (recursive map to the above)
" silent! vunmap <Tab>
" silent! vunmap <S-Tab>
vmap <special> <Tab>     >
vmap <special> <S-Tab>   <


" syntax match Repeat "loop" conceal cchar=∞

" CONCEAL
" -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

function! ToggleConcealLevel()
    if &conceallevel == 0
        setlocal conceallevel=2
    else
        setlocal conceallevel=0
    endif
endfunction

nnoremap <silent> <C-c><C-y> :call ToggleConcealLevel()<CR>

" COMPLETION
" -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

" Setup omnifunc for LSP
autocmd Filetype elixir,python,javascript,typescript,rust setlocal omnifunc=v:lua.vim.lsp.omnifunc

"" completion-nvim

" Attach to all buffers
" autocmd BufEnter * lua require'completion'.on_attach()

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" FILES
" -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

" Save file
nnoremap <Leader>w :w<CR>
" inoremap <Leader>s <C-c>:w<cr>

" Save even if we forgot to open the file with sudo
cmap w!! %!sudo tee > /dev/null %

" Quit file
nnoremap <Leader>q :q<CR>

" Start append in insert mode
inoremap <C-l> A<CR>

augroup YankHighlight
  " Highlight on yank
  autocmd! 
  au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=1000}
augroup end

" Handle autocomplete
" function! CleverTab()
"  if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
"     return "\<Tab>"
"  else
"     return "\<C-N>"
"  endif
" endfunction
" inoremap <Tab> <C-R>=CleverTab()<CR>

map <leader>hi :echo "hi<" . synIDattr(synID(line("."),col("."),1),"name") . '> trans<'
\ . synIDattr(synID(line("."),col("."),0),"name") . "> lo<"
\ . synIDattr(synIDtrans(synID(line("."),col("."),1)),"name") . ">"<CR>
