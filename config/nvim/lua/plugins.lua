--
-- Setup packer.nvim with all necessary plugins
--
-- Teej special code I stole :)
local ensure_packer_installed = function()
	local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])

	if not packer_exists then
		if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
			return false
		end

		local directory = string.format(
			"%s/site/pack/packer/opt/",
			vim.fn.stdpath("data")
		)

		vim.fn.mkdir(directory, "p")

		local out = vim.fn.system(
			string.format(
				"git clone %s %s",
				"https://github.com/wbthomason/packer.nvim",
				directory .. "/packer.nvim"
			)
		)
		print(out)
	end

	return true
end

local setup = function()
	if not ensure_packer_installed() then
		return
	end

	local packer = require("packer")

	packer.init({
		package_root = require("packer.util").join_paths(
			vim.fn.stdpath("data"),
			"site",
			"pack"
		),
	})

	packer.startup(function(use)
		-- Packer can manage itself as an optional plugin
		use({ "wbthomason/packer.nvim", opt = true })

		-- Plug 'arcticicestudio/nord-vim', { 'on': 'NERDTreeToggle' }
		use({ "bluz71/vim-moonfly-colors", opt = true })
		use({
			"ChristianChiarulli/nvcode-color-schemes.vim",
			opt = true,
		})

		-- Style css in styled-components
		use({ "styled-components/vim-styled-components" })

		-- Configure LSP
		use({ "neovim/nvim-lspconfig" })

		-- LSP Status Bar
		use({ "nvim-lua/lsp-status.nvim" })

		-- Express line (status bar)
		use({ "tjdevries/express_line.nvim" })

		-- Treesitter
		use({ "nvim-treesitter/nvim-treesitter" })

		use({ "nvim-treesitter/playground" })

		-- Completion from treesitter
		-- use({ "nvim-treesitter/completion-treesitter" })
		use({ "~/code/ejs-nvim", opt = true })

		-- Git commands
		use({ "tpope/vim-fugitive" })

    use({ "tpope/vim-dadbod"})

		-- Plug 'tpope/vim-sleuth'

		-- Auto-complete ends
		-- use({ "tpope/vim-endwise" })

		-- Dispatch jobs (like make, mix, yarn, tests)
		-- use({ "tpope/vim-dispatch" })

    use({ "vim-erlang/vim-erlang-runtime" })

		use({ "gleam-lang/gleam.vim" })

		-- sd Sandwich for wrapping variables
		-- Plug 'mchakann/vim-sandwich'
		use({ "tpope/vim-surround" })

		-- Distraction-free writing
		use({ "junegunn/goyo.vim" })

		use({ "junegunn/limelight.vim" })
		-- Tooltips
		-- Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

		-- Comment helpers
		use({ "tpope/vim-commentary" })
		use({ "JoosepAlviste/nvim-ts-context-commentstring" })

		-- Delve - Go Debugger
		use({ "sebdah/vim-delve", opt = true })

		-- Editorconfig support
		use({ "editorconfig/editorconfig-vim" })

		use({
			"kkoomen/vim-doge",
			config = function()
				vim.g.doge_enable_mappings = false
			end,
			run = function()
				vim.fn["doge#install"]()
			end,
		})

		use({ "mfussenegger/nvim-dap" })

		use({
			"rcarriga/nvim-dap-ui",
			requires = { "mfussenegger/nvim-dap" },
		})

		use({
			"theHamsta/nvim-dap-virtual-text",
			requires = { "mfussenegger/nvim-dap" },
		})

		-- use({ "David-Kunz/jester" })
		use({ "~/code/jester" })

		-- Neovim Lua Development
		use({ "~/code/nlua.nvim" })

		-- Colorizer
		use({ "norcalli/nvim-colorizer.lua" })

		-- LSP Extensions
		use({ "tjdevries/lsp_extensions.nvim" })

		use({ "~/code/vim-mjml", opt = true })

		use({ "nvim-lua/popup.nvim" })
		use({ "nvim-lua/plenary.nvim" })

		-- Telescope fuzzy finder
		-- use({ "nvim-telescope/telescope.nvim" })
		use({ "~/code/telescope.nvim" })
		use({
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "make",
		})

		use({ "kyazdani42/nvim-web-devicons" })

		use({ "~/code/boo-colorscheme-nvim" })

		-- Nightfly colors
		use({ "bluz71/vim-nightfly-guicolors" })

		-- TokyoNight colorscheme
		use({ "folke/tokyonight.nvim", opt = true })

		-- Emmet helpers for html/css
		use({ "mattn/emmet-vim" })

		-- Typescript LSP utilties
		use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })

		-- use({ "simrat39/symbols-outline.nvim" })

		use({ "onsails/lspkind-nvim" })

    use({ "mhartington/formatter.nvim" })

		-- Completion (nvim-cmp)
		-- use({ "hrsh7th/cmp-buffer" })
		use({
			"hrsh7th/cmp-nvim-lsp",
			requires = "onsails/lspkind-nvim",
		})
		use({ "hrsh7th/cmp-nvim-lua" })

		use({ "L3MON4D3/LuaSnip" })

		use({
			"hrsh7th/nvim-cmp",
			requires = {
				-- "hrsh7th/cmp-buffer",
				"hrsh7th/cmp-nvim-lsp",
				{
					"hrsh7th/cmp-nvim-lua",
					ft = "lua",
					-- this is after/plugin content
					config = function()
						require("cmp").register_source(
							"nvim_lua",
							require("cmp_nvim_lua").new()
						)
					end,
				},
				{
					"L3MON4D3/LuaSnip",
					wants = "rafamadriz/friendly-snippets",
				},
				"hrsh7th/cmp-vsnip",
				"saadparwaiz1/cmp_luasnip",
				"ray-x/cmp-treesitter",
			},
		})

		use({ "~/code/reload-lua" })

		-- A better annotation generator. Supports multiple languages and annotation conventions.
		use({
			"danymat/neogen",
			config = function()
				require("neogen").setup({
					enabled = true,
				})
			end,
			requires = "nvim-treesitter/nvim-treesitter",
		})

		-- Tabnine
		-- use({ "codota/tabnine-vim" })
		use({
			"~/build/tabnine-vim",
			opt = true,
			as = "codota/tabnine-vim",
		})
		use({
			"tzachar/cmp-tabnine",
			run = "./install.sh",
			-- after = "hrsh7th/nvim-cmp",
			event = "InsertEnter",
			requires = { "hrsh7th/nvim-cmp", "codata/tabnine-vim" },
			config = function()
				require("cmp_tabnine").setup()

				local tabnine = require("cmp_tabnine.config")
				tabnine:setup({
					max_lines = 1000,
					max_num_results = 20,
					sort = true,
					priority = 5000,
					show_prediction_strength = true,
				})
			end,
			opt = true,
		})

		use({ "lewis6991/impatient.nvim" })

		use({
			"yardnsm/vim-import-cost",
			run = "npm install --production",
		})

		use({ "norcalli/nvim-terminal.lua" })

		-- Fuzzy finder
		-- use {'junegunn/fzf', { 'do': { -> fzf#install() } }}
		-- use { 'junegunn/fzf.vim' }

		use({ "justinmk/vim-dirvish" })

		-- use({ "rcarriga/vim-ultest", requires = { { "janko/vim-test" } } })

		use({ "windwp/nvim-ts-autotag" })
		use({ "RRethy/nvim-treesitter-textsubjects" })

		use({
			"mfussenegger/nvim-ts-hint-textobject",
			config = function()
				require("tsht").config.hint_keys = {
					"h",
					"j",
					"f",
					"d",
					"n",
					"v",
					"s",
					"l",
					"a",
				}
			end,
		})

		-- Lua/Luv into vimdocs
		use({ "nanotee/luv-vimdocs" })
		use({ "milisims/nvim-luaref" })

		-- used for yarn pnp packaging
		use({
			"lbrayner/vim-rzip",
			config = function()
				--  Decode URI encoded characters
				vim.cmd([[
function! DecodeURI(uri)
    return substitute(a:uri, '%\([a-fA-F0-9][a-fA-F0-9]\)', '\=nr2char("0x" . submatch(1))', "g")
endfunction

" Attempt to clear non-focused buffers with matching name
function! ClearDuplicateBuffers(uri)
    " if our filename has URI encoded characters
    if DecodeURI(a:uri) !=# a:uri
        " wipeout buffer with URI decoded name - can print error if buffer in focus
        sil! exe "bwipeout " . fnameescape(DecodeURI(a:uri))
        " change the name of the current buffer to the URI decoded name
        exe "keepalt file " . fnameescape(DecodeURI(a:uri))
        " ensure we don't have any open buffer matching non-URI decoded name
        sil! exe "bwipeout " . fnameescape(a:uri)
    endif
endfunction

function! RzipOverride()
    " Disable vim-rzip's autocommands
    autocmd! zip BufReadCmd   zipfile:*,zipfile:*/*
    exe "au! zip BufReadCmd ".g:zipPlugin_ext

    " order is important here, setup name of new buffer correctly then fallback to vim-rzip's handling
    autocmd zip BufReadCmd   zipfile:*  call ClearDuplicateBuffers(expand("<amatch>"))
    autocmd zip BufReadCmd   zipfile:*  call rzip#Read(DecodeURI(expand("<amatch>")), 1)

    if has("unix")
        autocmd zip BufReadCmd   zipfile:*/*  call ClearDuplicateBuffers(expand("<amatch>"))
        autocmd zip BufReadCmd   zipfile:*/*  call rzip#Read(DecodeURI(expand("<amatch>")), 1)
    endif

    exe "au zip BufReadCmd ".g:zipPlugin_ext."  call rzip#Browse(DecodeURI(expand('<amatch>')))"
endfunction

autocmd VimEnter * call RzipOverride()]])
			end,
		})
	end)
end

return { setup = setup }
