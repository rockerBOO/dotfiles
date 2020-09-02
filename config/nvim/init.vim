let g:ale_disable_lsp = 1

" let g:ale_fixers = {
" \   '*': ['remove_trailing_lines', 'trim_whitespace'],
" \   'javascript': ['prettier', 'eslint'],
" \}

" mix format
"let g:mix_format_on_save = 1

" rustfmt
"let g:rustfmt_autosave = 1

" leafgarland/typescript-vim
" let g:typescript_indent_disable = 1

" prettier
" let g:prettier#autoformat = 1
" let g:prettier#autoformat_config_present = 1
" let g:prettier#autoformat_config_files = [".prettierrc.js"]

" ALE
" let g:ale_fix_on_save = 1

let g:diagnostic_enable_virtual_text = 1


call plug#begin()
 " Colors
	Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
	Plug 'haishanh/night-owl.vim'
	Plug 'arcticicestudio/nord-vim', { 'on': 'NERDTreeToggle' }

	" Configure LSP test this
	Plug 'neovim/nvim-lsp'

	" LSP Diagnostics
	Plug 'nvim-lua/diagnostic-nvim'

	Plug 'nvim-lua/completion-nvim'

	" Better syntax parsing
	"Plug 'nvim-treesitter/nvim-treesitter'

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

	" Git commands
	Plug 'tpope/vim-fugitive'

	"Plug 'tpope/vim-sleuth'

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

	" Teej tricking me into more plugins
	" Plug 'nvim-lua/plenary.nvim'

	" Neovim Lua Development
	" Plug 'tjdevries/nlua.nvim'

	" This is required for syntax highlighting
	" Plug 'euclidianAce/BetterLua.vim'

	" LSP Extensions
	Plug 'tjdevries/lsp_extensions.nvim'

	" Some stupid thing
	Plug 'ThePrimeagen/vim-be-good',

	" ES Linting
	Plug 'dense-analysis/ale'

	" JS/TS/HTML formatter
	Plug 'prettier/vim-prettier'


	" Telescope fuzzy finder
	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'
	Plug 'nvim-lua/telescope.nvim'

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
colorscheme challenger_deep

let mapleader = "\<Space>"


" configure lsp
lua << EOF
local on_attach_vim = function()
	require'completion'.on_attach()
	require'diagnostic'.on_attach()
end

require'nvim_lsp'.elixirls.setup{on_attach=on_attach_vim}
require'nvim_lsp'.rust_analyzer.setup{on_attach=on_attach_vim}
require'nvim_lsp'.tsserver.setup{on_attach=on_attach_vim}
require'nvim_lsp'.pyls.setup{}
require'nvim_lsp'.gopls.setup{}
require'nvim_lsp'.cssls.setup{}
require'nvim_lsp'.vimls.setup{}
require'nvim_lsp'.bashls.setup{}
require'nvim_lsp'.sumneko_lua.setup{}
EOF

" require'nvim-treesitter.configs'.setup {
"   highlight = {
"     enable = true
" 	}
" }
augroup ShowInlayHints
	autocmd!
	" autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true, prefix = ' ░ ', highlight = "Menu" }
	autocmd InsertLeave,BufEnter,BufCreate,BufWinEnter,TabEnter *.rs :lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "NonText" }
augroup end

" nnoremap <Leader>t :lua require'lsp_extensions'.inlay_hints{ only_current_line = true }<CR>
" nnoremap <Leader>asdf :lua require('plenary.reload').reload_module("lsp_extensions")<CR>

nnoremap <Leader>f :lua require'telescope.builtin'.git_files{ selection_strategy = "reset", shorten_path = true }<CR>

" Use deoplete.
" let g:deoplete#enable_at_startup = 1

syntax on

" Set path to search all sub directories
" set path+=**

" Control panes without using <C-w>
noremap <C-l> <C-w>l
noremap <C-h> <C-w>h
noremap <C-j> <C-w>j
noremap <C-k> <C-w>k

" Default split to bottom, right
set splitbelow
set splitright

set laststatus=2

set ff=unix

set wildmenu
set wildmode=longest:full,full

" Set tabs to 2
set tabstop=2
set shiftwidth=2
set softtabstop=2
set noexpandtab

" set mouse=a

" Run Prettier on save
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.md,*.json,*.graphql,*.vue,*.yaml,*.html Prettier

" Format before writing
autocmd BufWritePre *.py,*.rs lua vim.lsp.buf.formatting_sync({ insertSpaces = false, trimTrailingWhitespace = true, tabSize = 2, insertFinalNewline = true }, 1000)

" Setup omnifunc for LSP
autocmd Filetype elixir,python,javascript,ts,typescript,rust setlocal omnifunc=v:lua.vim.lsp.omnifunc

" Setup typescript syntax
autocmd BufNewFile,BufReadPost *.ts,*.tsx setfiletype typescript.vim

"" completion-nvim

" Attach to all buffers
" autocmd BufEnter * lua require'completion'.on_attach()

" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

" Avoid showing message extra message when using completion
set shortmess+=c

"" diagnostic-nvim

nnoremap <Leader>? :OpenDiagnostic<CR>

" tsx highlighting
" hi tsxTagName  ctermfg=blue
" hi tsxComponentName ctermfg=yellow

" ALE highlighting
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow

" Save file
nnoremap <Leader>w :w<CR>
"nnoremap <Leader>s :w<cr>
" inoremap <Leader>s <C-c>:w<cr>

" Quit file
nnoremap <Leader>q :q<CR>

" Start append in insert mode
inoremap <C-l> A<CR>

augroup LSPCursor
	autocmd CursorHold,CursorHoldI <buffer> :lua vim.lsp.buf.hover()
augroup END

" Setup default LSP keybinds
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
" nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
" nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> gr    <cmd>lua require'telescope.builtin'.lsp_references{}<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> <Leader>re <cmd>lua vim.lsp.buf.rename()<CR>
nnoremap <silent> <Leader>ca <cmd>lua vim.lsp.buf.code_action()<CR>

" Highlight on yank
au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=1000}


" Handle autocomplete
" function! CleverTab()
" 	 if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
" 			return "\<Tab>"
" 	 else
" 			return "\<C-N>"
" 	 endif
" endfunction
" inoremap <Tab> <C-R>=CleverTab()<CR>

map <Leader>o :NERDTreeToggle<CR>

" fzf file fuzzy search that respects .gitignore
" If in git directory, show only files that are committed, staged, or unstaged
" else use regular :Files
nnoremap <expr> <Leader>p (len(system('git rev-parse')) ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
