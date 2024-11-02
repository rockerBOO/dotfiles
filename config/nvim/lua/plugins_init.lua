--
-- Setup packer.nvim with all necessary plugins
--
-- local ensure_packer_installed = function()
-- 	local packer_exists = pcall(vim.cmd, [[packadd packer.nvim]])
--
-- 	if not packer_exists then
-- 		if vim.fn.input("Download Packer? (y for yes)") ~= "y" then
-- 			return false
-- 		end
--
-- 		local directory =
-- 			string.format("%s/site/pack/packer/opt/", vim.fn.stdpath("data"))
--
-- 		vim.fn.mkdir(directory, "p")
--
-- 		local out = vim.fn.system(
-- 			string.format(
-- 				"git clone %s %s",
-- 				"https://github.com/wbthomason/packer.nvim",
-- 				directory .. "/packer.nvim"
-- 			)
-- 		)
--
-- 		print(out)
-- 	end
--
-- 	return true
-- end

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"--branch=stable",
		lazyrepo,
		lazypath,
	})
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out, "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
	spec = {
		-- import your plugins
		{ import = "plugins" },
	},
	reset_packpath = false,
	-- Configure any other settings here. See the documentation for more details.
	-- colorscheme that will be used when installing plugins.
	-- install = { colorscheme = { "habamax" } },
	-- -- automatically check for plugin updates
	-- checker = { enabled = true },
})

local setup = function()
	-- if not ensure_packer_installed() then
	-- 	return
	-- end
	--
	-- local packer = require("packer")

	-- packer.init({
	-- 	package_root = require("packer.util").join_paths(
	-- 		vim.fn.stdpath("data"),
	-- 		"site",
	-- 		"pack"
	-- 	),
	-- })

	packer.startup(function(use)
		-- -- Packer can manage itself as an optional plugin
		-- use({ "wbthomason/packer.nvim", opt = true })

		-- Plug 'arcticicestudio/nord-vim', { 'on': 'NERDTreeToggle' }
		use({ "bluz71/vim-moonfly-colors", opt = true })
		use({
			"ChristianChiarulli/nvcode-color-schemes.vim",
			opt = true,
		})

		-- Style css in styled-components
		use({ "styled-components/vim-styled-components" })

		-- Configure LSP
		-- use({ "~/code/others/nvim-lspconfig" })
		use({ "neovim/nvim-lspconfig" })

		-- LSP Status Bar
		-- using temporay branch until deprecated feature is removed
		-- https://github.com/nvim-lua/lsp-status.nvim/pull/78
		-- use({ "nvim-lua/lsp-status.nvim" })
		-- use({ "tomtomjhj/lsp-status.nvim", branch = "deprecated" })

		-- Express line (status bar)
		-- use({ "tjdevries/express_line.nvim" })
		use({ "~/code/express_line.nvim" })

		-- Treesitter
		use({ "nvim-treesitter/nvim-treesitter" })
		-- use({ "~/code/nvim-treesitter" })
		use({ "nvim-treesitter/playground" })

		use({ "windwp/nvim-ts-autotag" })
		use({ "RRethy/nvim-treesitter-textsubjects" })

		-- use({
		-- 	"sindrets/diffview.nvim",
		-- 	requires = "nvim-lua/plenary.nvim",
		-- 	config = function()
		-- 		require("diffview").setup({})
		-- 	end,
		-- })

		--  use({
		--    "lewis6991/diffview.nvim",
		--    branch = "fixdepr",
		-- requires = "nvim-lua/plenary.nvim",
		-- config = function()
		-- 	require("diffview").setup({})
		-- end,
		--  })

		-- Linter
		use({ "mfussenegger/nvim-lint" })

		-- use({ "~/code/ejs-nvim", opt = true })

		-- Git commands
		use({ "tpope/vim-fugitive" })

		use({
			"petertriho/cmp-git",
			requires = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
		})

		use({
			"pwntester/octo.nvim",
			requires = {
				"nvim-lua/plenary.nvim",
				"nvim-telescope/telescope.nvim",
				-- "kyazdani42/nvim-web-devicons",
				"nvim-tree/nvim-web-devicons",
			},
			config = function()
				require("octo").setup()
			end,
		})

		-- DB
		use({ "tpope/vim-dadbod" })
		use({ "kristijanhusak/vim-dadbod-ui" })

		use({ "vim-erlang/vim-erlang-runtime" })

		-- use({ "gleam-lang/gleam.vim" })

		-- sd Sandwich for wrapping variables
		use({ "tpope/vim-surround" })

		-- Distraction-free writing
		use({ "junegunn/goyo.vim" })

		-- use({ "junegunn/limelight.vim" })

		-- Comment helpers
		use({
			"numToStr/Comment.nvim",
			config = function()
				require("Comment").setup()
			end,
		})
		use({ "JoosepAlviste/nvim-ts-context-commentstring" })

		-- Editorconfig support
		-- use({ "editorconfig/editorconfig-vim" })
		use({ "gpanders/editorconfig.nvim" })

		use("Samyak2/pest.vim", {
			branch = "neovim-lsp",
			config = function()
				require("pest-vim").setup({})
			end,
		})

		use({
			"kkoomen/vim-doge",
			config = function()
				vim.g.doge_enable_mappings = false
			end,
			run = function()
				vim.fn["doge#install"]()
			end,
		})

		use("jbyuki/one-small-step-for-vimkind")

		-- use({ "nvim-neotest/nvim-nio" })
		use({ "~/code/others/nvim-nio" })
		use({ "mfussenegger/nvim-dap" })
		-- use({ "~/code/nvim-dap" })

		use({
			-- "rcarriga/nvim-dap-ui",
			"~/code/others/nvim-dap-ui",
			requires = {
				"mfussenegger/nvim-dap",
				-- "nvim-neotest/nvim-nio",
			},
			config = function()
				require("dapui").setup({
					layouts = {

						{
							elements = {
								"repl",
								"console",
							},
							size = 0.25, -- 25% of total lines
							position = "bottom",
						},
						{
							elements = {
								-- Elements can be strings or table with id and size keys.
								{ id = "scopes", size = 0.25 },
								"breakpoints",
								"stacks",
								"watches",
							},
							size = 40, -- 40 columns
							position = "left",
						},
					},
				})
			end,
		})

		use({
			"theHamsta/nvim-semantic-tokens",
			config = function()
				require("nvim-semantic-tokens").setup({
					preset = "default",
					highlighters = {
						require("nvim-semantic-tokens.table-highlighter"),
					},
				})
			end,
		})

		use({
			"theHamsta/nvim-dap-virtual-text",
			requires = { "mfussenegger/nvim-dap" },
		})

		-- use({ "simrat39/rust-tools.nvim" })
		-- use("aszalowski/rust-tools.nvim")

		use({ "/home/rockerboo/code/rust-tools.nvim" })
		-- use("Ciel-MC/rust-tools.nvim")
		-- use({ "~/code/rust-tools.nvim" })

		use({
			"David-Kunz/jester",
			config = function()
				require("jester").setup({
					dap = {
						type = "yarn",
					},
					path_to_jest_debug = "test",
					path_to_jest_run = "test",
					-- cmd = "test -t '$result' -- $file", -- run command
				})
			end,
		})
		-- use({
		-- 	"/mnt/500h/rockerboo/code/jester",
		-- 	config = function()
		-- 		require("jester").setup()
		-- 	end,
		-- })

		-- Neovim Lua Development
		-- use({ "~/code/nlua.nvim" })

		use({
			"kyazdani42/nvim-tree.lua",
			requires = {
				-- "kyazdani42/nvim-web-devicons", -- optional, for file icons
				"nvim-tree/nvim-web-devicons",
			},
			config = function()
				require("nvim-tree").setup()
			end,
		})

		-- Colorizer
		-- use({ "norcalli/nvim-colorizer.lua" })
		use({ "~/code/nvim-colorizer.lua" })

		-- LSP Extensions
		-- use({ "tjdevries/lsp_extensions.nvim" })

		-- use({ "~/code/vim-mjml", opt = true })

		use({ "stevearc/dressing.nvim" })

		use({ "nvim-lua/popup.nvim" })
		use({ "nvim-lua/plenary.nvim" })

		use({
			"j-hui/fidget.nvim",
			tag = "legacy",
			config = function()
				require("fidget").setup({
					sources = { -- Sources to configure
						itex = { -- Name of source
							ignore = true, -- Ignore notifications from this source
						},
					},
					-- fmt = {
					-- 	max_messages = 2,
					-- },
				})
			end,
		})

		-- Telescope fuzzy finder
		use({ "nvim-telescope/telescope.nvim" })
		-- use({ "~/code/telescope.nvim" })
		use({
			"nvim-telescope/telescope-fzf-native.nvim",
			run = "make",
		})

		use({
			"nvim-telescope/telescope-dap.nvim",
			require = "nvim-telescope/telescope.nvim",
		})

		use({
			"mfussenegger/nvim-dap-python",
			requires = { "nvim-telescope/telescope-dap.nvim" },
		})

		-- use({ "kyazdani42/nvim-web-devicons" })
		use({ "nvim-tree/nvim-web-devicons" })

		use("ThePrimeagen/harpoon")

		use({ "/mnt/500h/rockerboo/code/boo-colorscheme-nvim" })
		-- use({ "rockerBOO/boo-colorscheme-nvim" })

		-- Nightfly colors
		use({ "bluz71/vim-nightfly-guicolors" })

		-- TokyoNight colorscheme
		use({ "folke/tokyonight.nvim" })

		-- Emmet helpers for html/css
		use({ "mattn/emmet-vim" })

		-- Typescript LSP utilties
		-- use({ "jose-elias-alvarez/nvim-lsp-ts-utils" })
		use({
			"jose-elias-alvarez/typescript.nvim",
		})

		-- use({ "simrat39/symbols-outline.nvim" })

		-- use({ "rockerBOO/symbols-outline.nvim"})
		use({ "~/code/symbols-outline.nvim" })

		use({ "onsails/lspkind-nvim" })

		use({
			"folke/trouble.nvim",
			config = function()
				require("trouble").setup({})
			end,
		})

		use({ "mhartington/formatter.nvim" })
		-- use({ "~/code/others/formatter.nvim" })

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

		use({ "b0o/schemastore.nvim" })

		-- use({ "~/code/reload-lua" })

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
		-- use({
		-- 	"~/build/tabnine-vim",
		-- 	opt = true,
		-- 	as = "codota/tabnine-vim",
		-- })

		-- use({ "codota/tabnine-nvim", run = "./dl_binaries.sh" })

		-- use({
		-- 	"tzachar/cmp-tabnine",
		-- 	run = "./install.sh",
		-- 	-- after = "hrsh7th/nvim-cmp",
		-- 	event = "InsertEnter",
		-- 	requires = { "hrsh7th/nvim-cmp", "codata/tabnine-nvim" },
		-- 	config = function()
		-- 		require("tabnine").setup({
		-- 			max_lines = 1000,
		-- 			max_num_results = 20,
		-- 			sort = true,
		-- 			exclude_filetypes = { "TelescopePrompt" },
		-- 			-- priority = 5000,
		-- 			debounce_ms = 800,
		-- 			show_prediction_strength = true,
		-- 		})
		-- 	end,
		-- 	opt = true,
		-- })

		use({ "lewis6991/impatient.nvim" })
		-- fork using sqlite
		-- use({ "tami5/impatient.nvim", requires = { "tami5/sqlite.lua" } })

		use({ "norcalli/nvim-terminal.lua" })

		-- Fuzzy finder

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

		use("takac/vim-hardtime")

		-- use({
		-- 	"mhanberg/elixir.nvim",
		-- 	requires = { "neovim/nvim-lspconfig", "nvim-lua/plenary.nvim" },
		-- 	config = function()
		-- 	end,
		-- })
		use({
			"hrsh7th/cmp-nvim-lsp-signature-help",
			requires = { "hrsh7th/nvim-cmp" },
		})

		-- use({ "nullchilly/fsread.nvim" })
		-- use({ "~/code/others/fsread.nvim" })

		-- used for yarn pnp packaging
		-- 		use({
		-- 			"lbrayner/vim-rzip",
		-- 			config = function()
		-- 				--  Decode URI encoded characters
		-- 				vim.cmd([[
		-- function! DecodeURI(uri)
		--     return substitute(a:uri, '%\([a-fA-F0-9][a-fA-F0-9]\)', '\=nr2char("0x" . submatch(1))', "g")
		-- endfunction
		--
		-- " Attempt to clear non-focused buffers with matching name
		-- function! ClearDuplicateBuffers(uri)
		--     " if our filename has URI encoded characters
		--     if DecodeURI(a:uri) !=# a:uri
		--         " wipeout buffer with URI decoded name - can print error if buffer in focus
		--         sil! exe "bwipeout " . fnameescape(DecodeURI(a:uri))
		--         " change the name of the current buffer to the URI decoded name
		--         exe "keepalt file " . fnameescape(DecodeURI(a:uri))
		--         " ensure we don't have any open buffer matching non-URI decoded name
		--         sil! exe "bwipeout " . fnameescape(a:uri)
		--     endif
		-- endfunction
		--
		-- function! RzipOverride()
		--     " Disable vim-rzip's autocommands
		--     autocmd! zip BufReadCmd   zipfile:*,zipfile:*/*
		--     exe "au! zip BufReadCmd ".g:zipPlugin_ext
		--
		--     " order is important here, setup name of new buffer correctly then fallback to vim-rzip's handling
		--     autocmd zip BufReadCmd   zipfile:*  call ClearDuplicateBuffers(expand("<amatch>"))
		--     autocmd zip BufReadCmd   zipfile:*  call rzip#Read(DecodeURI(expand("<amatch>")), 1)
		--
		--     if has("unix")
		--         autocmd zip BufReadCmd   zipfile:*/*  call ClearDuplicateBuffers(expand("<amatch>"))
		--         autocmd zip BufReadCmd   zipfile:*/*  call rzip#Read(DecodeURI(expand("<amatch>")), 1)
		--     endif
		--
		--     exe "au zip BufReadCmd ".g:zipPlugin_ext."  call rzip#Browse(DecodeURI(expand('<amatch>')))"
		-- endfunction
		--
		-- autocmd VimEnter * call RzipOverride()]])
		-- 			end,
		-- 		})

		use("alaviss/nim.nvim")

		use({ "MunifTanjim/nui.nvim" })

		use({
			"yetone/avante.nvim",
			config = function()
				local opts = {
					provider = "ollama",
					ollama = {
						["local"] = true,
						endpoint = "127.0.0.1:11434/v1",
						-- model = "codegemma",
						model = "llama3.1:latest",
						parse_curl_args = function(opts, code_opts)
							return {
								url = opts.endpoint .. "/chat/completions",
								headers = {
									["Accept"] = "application/json",
									["Content-Type"] = "application/json",
								},
								body = {
									model = opts.model,
									messages = require("avante.providers").copilot.parse_message(
										code_opts
									), -- you can make your own message, but this is very advanced
									max_tokens = 2048,
									stream = true,
								},
							}
						end,
						parse_response_data = function(
							data_stream,
							event_state,
							opts
						)
							require("avante.providers").openai.parse_response(
								data_stream,
								event_state,
								opts
							)
						end,
					},
				}
				require("avante.config").setup(opts)
			end,
		})

		use({
			"MeanderingProgrammer/render-markdown.nvim",
			-- opts = {
			-- 	file_types = { "markdown", "Avante" },
			-- },
			-- ft = { "markdown", "Avante" },
		})

		-- use("numToStr/FTerm.nvim")

		-- use({
		-- 	"chrisgrieser/nvim-puppeteer",
		-- 	requires = "nvim-treesitter/nvim-treesitter",
		-- })

		-- use({
		-- 	"krivahtoo/silicon.nvim",
		-- 	run = "./install.sh",
		-- 	config = function()
		-- 		require("silicon").setup({
		-- 			font = "Isoveka=16",
		-- 		})
		-- 	end,
		-- })
	end)

	local group = vim.api.nvim_create_augroup("packer_user_config", {})

	vim.api.nvim_create_autocmd("BufWritePost", {
		group = group,
		pattern = "plugins.lua",
		callback = function()
			vim.cmd("source <afile>")
			require("plugins").setup()
			vim.cmd("PackerCompile")
		end,
	})
end

return { setup = setup }
