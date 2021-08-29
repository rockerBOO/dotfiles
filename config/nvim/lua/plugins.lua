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

		local directory = string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))

		vim.fn.mkdir(directory, "p")

		local out =
			vim.fn.system(string.format(
				"git clone %s %s",
				"https://github.com/wbthomason/packer.nvim",
				directory .. "/packer.nvim"
			))
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
		package_root = require("packer.util").join_paths(vim.fn.stdpath("data"), "site", "pack"),
	})

	packer.startup(function(use)
		-- Packer can manage itself as an optional plugin
		use({ "wbthomason/packer.nvim", opt = true })

		-- Plug 'arcticicestudio/nord-vim', { 'on': 'NERDTreeToggle' }
		use({ "bluz71/vim-moonfly-colors" })
		use({ "ChristianChiarulli/nvcode-color-schemes.vim" })

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

		-- Git commands
		use({ "tpope/vim-fugitive" })

		-- Plug 'tpope/vim-sleuth'

		-- Auto-complete ends
		use({ "tpope/vim-endwise" })

		-- Dispatch jobs (like make, mix, yarn, tests)
		use({ "tpope/vim-dispatch" })

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

		-- Delve - Go Debugger
		use({ "sebdah/vim-delve" })

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

		-- Neovim Lua Development
		use({ "~/code/nlua.nvim" })

		-- Colorizer
		use({ "norcalli/nvim-colorizer.lua" })

		-- LSP Extensions
		use({ "tjdevries/lsp_extensions.nvim" })

		use({ "nvim-lua/popup.nvim" })
		use({ "nvim-lua/plenary.nvim" })

		-- Telescope fuzzy finder
		use({ "nvim-telescope/telescope.nvim" })
		use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })

		use({ "kyazdani42/nvim-web-devicons" })

		use({ "~/code/boo-colorscheme-nvim", branch = "main" })

		-- Nightfly colors
		use({ "bluz71/vim-nightfly-guicolors" })

		-- TokyoNight colorscheme
		use({ "folke/tokyonight.nvim" })

		-- Typescript LSP utilties
		use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })

		use({ "simrat39/symbols-outline.nvim" })

		use({ "onsails/lspkind-nvim" })

		-- Completion (nvim-cmp)
		-- use({ "hrsh7th/cmp-buffer" })
		use({ "hrsh7th/cmp-nvim-lsp", requires = "onsails/lspkind-nvim" })
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
						require("cmp").register_source("nvim_lua", require("cmp_nvim_lua").new())
					end,
				},
				{
					"L3MON4D3/LuaSnip",
					wants = "rafamadriz/friendly-snippets",
				},
				"hrsh7th/cmp-vsnip",
				"saadparwaiz1/cmp_luasnip",
			},
		})

		-- Tabnine
		-- use({ "codota/tabnine-vim" })
		use({ "~/build/tabnine-vim", opt = true })
		use({
			"tzachar/cmp-tabnine",
			run = "./install.sh",
			-- after = "hrsh7th/nvim-cmp",
			event = "InsertEnter",
			requires = { "hrsh7th/nvim-cmp", "codata/tabnine-vim" },
			config = function()
				require("cmp_tabnine").setup()
			end,
			opt = true,
		})

		use({ "norcalli/nvim-terminal.lua" })

		-- Fuzzy finder
		-- use {'junegunn/fzf', { 'do': { -> fzf#install() } }}
		-- use { 'junegunn/fzf.vim' }

		use({ "justinmk/vim-dirvish" })

		-- use({ "rcarriga/vim-ultest", requires = { { "janko/vim-test" } } })

		use({ "windwp/nvim-ts-autotag" })

		use({ "mfussenegger/nvim-ts-hint-textobject" })
	end)
end

return { setup = setup }
