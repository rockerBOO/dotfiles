return {
	-- {
	-- 	"hrsh7th/nvim-cmp",
	-- 	dependencies = {
	-- 		-- "hrsh7th/cmp-buffer",
	-- 		"hrsh7th/cmp-nvim-lsp",
	-- 		{
	-- 			"hrsh7th/cmp-nvim-lua",
	-- 			ft = "lua",
	-- 			-- this is after/plugin content
	-- 			config = function()
	-- 				require("cmp").register_source(
	-- 					"nvim_lua",
	-- 					require("cmp_nvim_lua").new()
	-- 				)
	-- 			end,
	-- 		},
	-- 		{
	-- 			"L3MON4D3/LuaSnip",
	-- 			wants = "rafamadriz/friendly-snippets",
	-- 		},
	-- 		"hrsh7th/cmp-vsnip",
	-- 		"saadparwaiz1/cmp_luasnip",
	-- 		"ray-x/cmp-treesitter",
	-- 	},
	-- },
	-- {
	-- 	"petertriho/cmp-git",
	-- 	dependencies = { "nvim-lua/plenary.nvim", "hrsh7th/nvim-cmp" },
	-- },
	--
	--
	-- "hrsh7th/cmp-nvim-lua",
	--
	-- {
	-- 	"milanglacier/minuet-ai.nvim",
	-- 	dependencies = { "Saghen/blink.cmp" },
	-- 	config = function()
	-- 		require("minuet").setup({
	-- 			provider = "openai_fim_compatible",
	-- 			n_completions = 1, -- recommend for local model for resource saving
	-- 			-- I recommend beginning with a small context window size and incrementally
	-- 			-- expanding it, depending on your local computing power. A context window
	-- 			-- of 512, serves as an good starting point to estimate your computing
	-- 			-- power. Once you have a reliable estimate of your local computing power,
	-- 			-- you should adjust the context window to a larger value.
	-- 			context_window = 512,
	-- 			provider_options = {
	-- 				openai_fim_compatible = {
	-- 					api_key = "TERM",
	-- 					name = "Llama.cpp",
	-- 					end_point = "http://localhost:8012/v1/completions",
	-- 					-- The model is set by the llama-cpp server and cannot be altered
	-- 					-- post-launch.
	-- 					model = "PLACEHOLDER",
	-- 					optional = {
	-- 						max_tokens = 56,
	-- 						top_p = 0.9,
	-- 					},
	-- 					-- Llama.cpp does not support the `suffix` option in FIM completion.
	-- 					-- Therefore, we must disable it and manually populate the special
	-- 					-- tokens required for FIM completion.
	-- 					template = {
	--
	-- 						prompt = function(
	-- 							context_before_cursor,
	-- 							context_after_cursor
	-- 						)
	-- 							return "<|fim_prefix|>"
	-- 								.. context_before_cursor
	-- 								.. "<|fim_suffix|>"
	-- 								.. context_after_cursor
	-- 								.. "<|fim_middle|>"
	-- 						end,
	-- 						suffix = false,
	-- 					},
	-- 				},
	-- 			},
	--
	-- 			notify = "info",
	-- 			virtualtext = {
	-- 				auto_trigger_ft = {},
	--
	-- 				keymap = {
	-- 					-- accept whole completion
	-- 					accept = "<A-A>",
	-- 					-- accept one line
	-- 					accept_line = "<A-a>",
	-- 					-- accept n lines (prompts for number)
	-- 					-- e.g. "A-z 2 CR" will accept 2 lines
	-- 					accept_n_lines = "<A-z>",
	-- 					-- Cycle to prev completion item, or manually invoke completion
	-- 					prev = "<A-[>",
	-- 					-- Cycle to next completion item, or manually invoke completion
	-- 					next = "<A-]>",
	-- 					dismiss = "<A-e>",
	-- 				},
	-- 			},
	-- 		})
	-- 	end,
	-- },
	{
		"saghen/blink.cmp",
		-- optional: provides snippets for the snippet source
		dependencies = {
			"rafamadriz/friendly-snippets",
			"milanglacier/minuet-ai.nvim",
		},

		-- use a release tag to download pre-built binaries
		version = "1.*",
		-- AND/OR build from source, requires nightly: https://rust-lang.github.io/rustup/concepts/channels.html#working-with-nightly-rust
		-- build = 'cargo build --release',
		-- If you use nix, you can build from source using latest nightly rust with:
		-- build = 'nix run .#build-plugin',

		---@module 'blink.cmp'
		---@type blink.cmp.Config
		opts = {
			-- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
			-- 'super-tab' for mappings similar to vscode (tab to accept)
			-- 'enter' for enter to accept
			-- 'none' for no mappings
			--
			-- All presets have the following mappings:
			-- C-space: Open menu or open docs if already open
			-- C-n/C-p or Up/Down: Select next/previous item
			-- C-e: Hide menu
			-- C-k: Toggle signature help (if signature.enabled = true)
			--
			-- See :h blink-cmp-config-keymap for defining your own keymap
			keymap = {
				preset = "default",

				-- Manually invoke minuet completion.
				-- ["<A-y>"] = function() require("minuet").make_blink_map(),
				["<CR>"] = {
					function(cmp)
						if cmp.snippet_active() then
							return cmp.accept()
						else
							return cmp.select_and_accept()
						end
					end,
					"snippet_forward",
					"fallback",
				},
			},

			appearance = {
				-- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
				-- Adjusts spacing to ensure icons are aligned
				nerd_font_variant = "mono",
			},

			-- (Default) Only show the documentation popup when manually triggered
			completion = {
				documentation = { auto_show = false },
				-- Recommended to avoid unnecessary request
				trigger = { prefetch_on_insert = false },
			},

			-- Default list of enabled providers defined so that you can extend it
			-- elsewhere in your config, without redefining it, due to `opts_extend`
			sources = {
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				-- For manual completion only, remove 'minuet' from default
				-- default = { "lsp", "path", "snippets", "buffer", "minuet" },
				-- -- For manual completion only, remove 'minuet' from default
				-- providers = {
				-- 	minuet = {
				-- 		name = "minuet",
				-- 		module = "minuet.blink",
				-- 		score_offset = 8, -- Gives minuet higher priority among suggestions
				-- 	},
				-- },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},

			-- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
			-- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
			-- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
			--
			-- See the fuzzy documentation for more information
			fuzzy = { implementation = "prefer_rust_with_warning" },
		},
		opts_extend = { "sources.default" },
	},
}
