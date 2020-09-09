let mapleader = "\<Space>"

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



" Configure the completion chains
let g:completion_chain_complete_list = {
			\'default' : {
			\	'default' : [
			\		{'complete_items' : ['lsp', 'snippet']},
      \   {'complete_items' : ['buffer']},
			\		{'mode' : 'file'}
			\	],
			\}
			\}


" ALE
" let g:ale_fix_on_save = 1
" diagnostic-nvim
let g:diagnostic_enable_virtual_text = 1
let g:diagnostic_auto_popup_while_jump = 1
 
call plug#begin()
 " Colors
	Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
	Plug 'haishanh/night-owl.vim'
	Plug 'arcticicestudio/nord-vim', { 'on': 'NERDTreeToggle' }

	" Configure LSP test this
	Plug 'neovim/nvim-lsp'

	" LSP Diagnostics
	Plug 'nvim-lua/diagnostic-nvim'

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
  " Plug 'mhinz/vim-mix-format'
	Plug 'moofish32/vim-ex_test'

	" File tree
	Plug 'preservim/nerdtree'

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

	" This is required for syntax highlighting
	Plug 'euclidianAce/BetterLua.vim'

	" LSP Extensions
	Plug 'tjdevries/lsp_extensions.nvim'

	" Some stupid thing
	Plug 'ThePrimeagen/vim-be-good',

	" ES Linting
	"Plug 'dense-analysis/ale'

	Plug 'andrejlevkovitch/vim-lua-format'

	" JS/TS/HTML formatter
	Plug 'prettier/vim-prettier'


	Plug 'nvim-lua/popup.nvim'
	Plug 'nvim-lua/plenary.nvim'

	" Telescope fuzzy finder
	Plug 'nvim-lua/telescope.nvim'

	" Fuzzy finder
	Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
	Plug 'junegunn/fzf.vim'
call plug#end()

if (has("termguicolors"))
 set termguicolors
endif

" colors
colorscheme challenger_deep

" Open this file in a new tab
nnoremap <Leader>en :tabnew ~/.config/nvim/init.vim<CR>



" Reload init.vim, this currently locks up nvim
augroup ReloadNvim 
	au BufWritePost ~/.config/nvim/init.vim :source ~/.config/nvim/init.vim
augroup end


"au FileType rust :lua require'nvim_lsp'.rust_analyzer.setup{on_attach=on_attach_vim}<CR>

" configure lsp
lua require'lsp_config' 

augroup ShowInlayHints
  autocmd!
  " autocmd CursorHold,CursorHoldI *.rs :lua require'lsp_extensions'.inlay_hints{ only_current_line = true, prefix = ' ░ ', highlight = "Menu" }
  autocmd InsertLeave,BufEnter,BufCreate,BufWinEnter,TabEnter,BufWritePost FileType rust :lua require'lsp_extensions'.inlay_hints{ prefix = '', highlight = "NonText" }
augroup end

" nnoremap <Leader>asdf :lua require('plenary.reload').reload_module("lsp_extensions")<CR>

" Telescope binds 
nnoremap <Leader>f :lua GitFiles()<CR>
" augroup TelescopeBindings
" 	autocmd!
" 	autocmd FileType elixir,rust,javascript,typescript nnoremap ggr :lua LspWorkspaceSymbols()<CR>
" augroup end
nnoremap ggr :lua LspWorkspaceSymbols()<CR>

nnoremap <Leader>P :lua require'telescope.builtin'.planets{}<CR>

nnoremap <Leader>gr :lua LiveGrep()<CR>

function! LspStatus() abort
  if luaeval('#vim.lsp.buf_get_clients() > 0')
    return luaeval("require('lsp-status').status()")
  endif

  return ''
endfunction

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

" Escape in insert mode 
inoremap jk <esc>

" Training new escape key
" inoremap <esc> <nop>

" Training off arrow keys
inoremap <Up> <nop>
inoremap <Down> <nop>


" ----------------------------------------------------------------------------
" Reselect visual block after indent
" ----------------------------------------------------------------------------

xnoremap  <   <gv
xnoremap  >   >gv

" set mouse=a
augroup Prettier
	autocmd!	
	" Run Prettier on save
	autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.md,*.json,*.graphql,*.vue,*.yaml,*.html Prettier
augroup end

augroup LSPFormatting
	autocmd!
" Format before writing
	autocmd BufWritePre *.ex,*.exs,*.py,*.rs lua vim.lsp.buf.formatting_sync({  trimTrailingWhitespace = true, tabSize = 2, insertFinalNewline = true }, 1000)
augroup end

augroup LuaFormatter
	autocmd FileType lua nnoremap <buffer> <c-k> :call LuaFormat()<cr>
  "autocmd BufWrite *.lua call LuaFormat()
augroup end

" Setup omnifunc for LSP
" autocmd Filetype elixir,python,javascript,ts,typescript,rust setlocal omnifunc=v:lua.vim.lsp.omnifunc

augroup TypescriptSyntax
	" Setup typescript syntax
	autocmd FileType typescript :set makeprg=tsc	
	
	" set filetypes as typescript.tsx
	autocmd BufNewFile,BufRead *.tsx,*.jsx set filetype=typescript.tsx

	autocmd BufNewFile,BufReadPost *.ts setfiletype typescript.vim
augroup end

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
nnoremap <Leader>k :PrevDiagnosticCycle<CR>
nnoremap <Leader>j :NextDiagnosticCycle<CR>


" tsx highlighting
" hi tsxTagName  ctermfg=blue
" hi tsxComponentName ctermfg=yellow

" ALE highlighting
highlight ALEErrorSign ctermbg=NONE ctermfg=red
highlight ALEWarningSign ctermbg=NONE ctermfg=yellow


" dark red
hi tsxTagName ctermfg=red
hi tsxComponentName ctermfg=red
hi tsxCloseComponentName ctermfg=red

" orange
hi tsxCloseString ctermfg=cyan
hi tsxCloseTag ctermfg=cyan
hi tsxCloseTagName ctermfg=cyan
hi tsxAttributeBraces ctermfg=cyan
hi tsxEqual ctermfg=cyan

" yellow
hi tsxAttrib ctermfg=yellow cterm=italic

" FILES
" -->==>-->==>-->==>-->==>

nnoremap <Leader>r :Dispatch make<CR>

augroup Dispatch
	autocmd!
	au FileType rust nnoremap <Leader>r :Dispatch cargo run --bin plant_game<CR>
	au FileType rust nnoremap <Leader>t :Dispatch cargo test<CR>
	au FileType elixir nnoremap <Leader>r :Dispatch mix run<CR> 
	au FileType elixir nnoremap <Leader>t :Dispatch mix test<CR>
augroup end

" Save file
nnoremap <Leader>w :w<CR>
"nnoremap <Leader>s :w<cr>
" inoremap <Leader>s <C-c>:w<cr>

" Quit file
nnoremap <Leader>q :q<CR>

" Start append in insert mode
inoremap <C-l> A<CR>

augroup LSPCursor
	autocmd!
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

augroup YankHighlight
	" Highlight on yank
  autocmd! 
	au TextYankPost * silent! lua vim.highlight.on_yank {higroup="IncSearch", timeout=1000}
augroup end

" Handle autocomplete
" function! CleverTab()
"	 if strpart( getline('.'), 0, col('.')-1 ) =~ '^\s*$'
"			return "\<Tab>"
"	 else
"			return "\<C-N>"
"	 endif
" endfunction
" inoremap <Tab> <C-R>=CleverTab()<CR>

map <Leader>o :NERDTreeToggle<CR>

" fzf file fuzzy search that respects .gitignore
" If in git directory, show only files that are committed, staged, or unstaged
" else use regular :Files
nnoremap <expr> <Leader>p (len(system('git rev-parse')) > 0 ? ':Files' : ':GFiles --exclude-standard --others --cached')."\<cr>"
