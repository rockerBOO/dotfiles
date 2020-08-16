call plug#begin()
 " Colors
	Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
	Plug 'haishanh/night-owl.vim'

	" Configure LSP
	Plug 'neovim/nvim-lsp'

	" LSP Diagnostics
	Plug 'nvim-lua/diagnostic-nvim'

	" Better syntax parsing
  Plug 'nvim-treesitter/nvim-treesitter'

	" Indent rules for python
	Plug 'vim-scripts/indentpython.vim'

	" Rust syntax rules
  Plug 'rust-lang/rust.vim'

	 " Elixir synxtax rules
  Plug 'elixir-editors/vim-elixir'
	" Plug 'slashmili/alchemist.vim'
	" Plug 'mhinz/vim-mix-format'
  " Plug 'moofish32/vim-ex_test'

	" File tree
	Plug 'preservim/nerdtree'


	" Auto-complete ends 
	Plug 'tpope/vim-endwise'

	" sd Sandwich for wrapping variables
	Plug 'mchakann/vim-sandwich'
	"Plug 'tpope/vim-surround'

  " Tooltips
	" Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

	Plug 'tpope/vim-commentary'

	" Typescript
  Plug 'leafgarland/typescript-vim'
  Plug 'peitalin/vim-jsx-typescript'


	" ES Linting
	" Plug 'w0rp/ale'
  
	" JS/TS/HTML formatter
	Plug 'prettier/vim-prettier'


	" Fuzzy finder
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
	" Plug 'nvim-lua/completion-nvim'
  " Plug 'SirVer/ultisnips'
call plug#end()

if (has("termguicolors"))
 set termguicolors
endif

" colors
colorscheme night-owl 

" configure lsp
lua << EOF
require'nvim_lsp'.elixirls.setup{}
require'nvim_lsp'.rust_analyzer.setup{on_attach=require'diagnostic'.on_attach}
require'nvim_lsp'.tsserver.setup{}
require'nvim_lsp'.pyls.setup{}
require'nvim_lsp'.cssls.setup{}
require'nvim_lsp'.vimls.setup{}
require'nvim_lsp'.bashls.setup{}
require'nvim_lsp'.sumneko_lua.setup{}
EOF
" Use deoplete.
let g:deoplete#enable_at_startup = 1

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['prettier', 'eslint'],
\}

syntax on
let mapleader = ","

set laststatus=2
set wildmenu

" Set tabs to 2
set tabstop=2
set shiftwidth=2
set softtabstop=2
set noexpandtab

" mix format
"let g:mix_format_on_save = 1

" rustfmt
"let g:rustfmt_autosave = 1

" leafgarland/typescript-vim
let g:typescript_indent_disable = 1

" prettier
"let g:prettier#autoformat = 1
"let g:prettier#autoformat_config_present = 1
"let g:prettier#autoformat_config_files = [".prettierrc.js"]

" ALE
let g:ale_fix_on_save = 1

" Run Prettier on save
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.md,*.json,*.graphql,*.vue,*.yaml,*.html Prettier

" Format before writing
autocmd BufWritePre *.rs,*.ex,*.exs lua vim.lsp.buf.formatting_sync(nil, 1000)

" Setup omnifunc for LSP 
autocmd Filetype python,ts,typescript,rust setlocal omnifunc=v:lua.vim.lsp.omnifunc

" Setup typescript syntax
autocmd BufNewFile,BufReadPost *.ts,*.tsx setfiletype typescript.vim

" tsx highlighting
hi tsxTagName  ctermfg=blue
hi tsxComponentName ctermfg=yellow

" ALE highlighting
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

" Setup default LSP keybinds
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>

" Handle autocomplete 
function! CleverTab()
	 if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
			return "\<Tab>"
	 else
			return "\<C-N>"
	 endif
endfunction
inoremap <Tab> <C-R>=CleverTab()<CR>

map <C-n> :NERDTreeToggle<CR>

" fzf file fuzzy search that respects .gitignore
" If in git directory, show only files that are committed, staged, or unstaged
" else use regular :Files
nnoremap <expr> <C-p> (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
