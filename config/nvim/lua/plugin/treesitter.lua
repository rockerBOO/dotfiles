local treesitter = {}
-- local ft_to_parser = require("nvim-treesitter.parsers").filetype_to_parsername

treesitter.setup = function()
	-- 	require("nvim-treesitter.configs").setup({
	-- 		-- modules and its options go here
	-- 		highlight = { enable = true },
	-- 		-- context_commentstring = {
	-- 		-- 	enable = true,
	-- 		-- },
	-- 		incremental_selection = {
	-- 			enable = true,
	-- 			keymaps = {
	-- 				init_selection = "gnn",
	-- 				node_incremental = "gnr",
	-- 				scope_incremental = "gnc",
	-- 				node_decremental = "gnm",
	-- 			},
	-- 		},
	-- 		indent = {
	-- 			enable = true,
	-- 		},
	-- 		textsubjects = {
	-- 			enable = true,
	-- 			keymaps = {
	-- 				["."] = "textsubjects-smart",
	-- 				[";"] = "textsubjects-container-outer",
	-- 			},
	-- 		},
	-- 		textobjects = {
	-- 			enable = true,
	-- 			select = {
	-- 				enable = true,
	-- 				keymaps = {
	-- 					["af"] = "@function.outer",
	-- 					["if"] = "@function.inner",
	-- 					["ac"] = "@class.outer",
	-- 					["ic"] = "@class.inner",
	-- 				},
	-- 			},
	-- 		},
	-- 		-- playground = {
	-- 		-- 	enable = true,
	-- 		-- 	disable = {},
	-- 		-- 	updatetime = 25,
	-- 		-- 	persist_queries = false,
	-- 		-- },
	-- 		query_linter = {
	-- 			enable = true,
	-- 			use_virtual_text = true,
	-- 			lint_events = { "BufWrite", "CursorHold" },
	-- 		},
	-- 		additional_vim_regex_hjighlighting = false,
	-- 		ensure_installed = {
	-- 			"elixir",
	-- 			"lua",
	-- 			"eex",
	-- 			"html",
	-- 			"css",
	-- 			"typescript",
	-- 			"javascript",
	-- 			"tsx",
	-- 			"rust",
	-- 			"python",
	-- 			"json",
	-- 		},
	-- 	})
	require("nvim-treesitter").setup({
		local_parsers = {
			-- zsh = {
			-- 	source = {
			-- 		type = "self_contained",
			-- 		url = "https://github.com/georgeharker/tree-sitter-zsh",
			-- 		semver = false,
			-- 		queries_path = "nvim-queries/zsh",
			-- 	},
			-- 	filetypes = { "zsh" },
			-- },

			gotmpl = {
				source = {
					url = "https://github.com/ngalaiko/tree-sitter-go-template",
					files = { "src/parser.c" },
				},
				filetypes = { "gotmpl" },
				-- used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl", "yaml"}
			},
			crystal = {
				source = {
					url = "https://github.com/crystal-lang-tools/tree-sitter",
					files = { "src/parser.c" },
					branch = "main",
				},
				filetypes = { "crystal", "ecrystal" },
			},
		},
	})

	-- Not quite sure but deprecated module said to use this
	require("ts_context_commentstring").setup({})
	vim.g.skip_ts_context_commentstring_module = true

	-- local parser_config =
	-- 	require("nvim-treesitter.parsers").get_parser_configs()

	-- parser_config.gleam = {
	-- 	install_info = {
	-- 		url = "~/code/tree-sitter-gleam", -- local path or git repo
	-- 		files = { "src/parser.c" },
	-- 	},
	-- 	filetype = "gleam", -- if filetype does not agrees with parser name
	-- }

	-- parser_config.markdown = {
	-- 	install_info = {
	-- 		url = "~/code/tree-sitter-markdown", -- local path or git repo
	-- 		files = { "src/parser.c" },
	-- 	},
	-- 	filetype = "markdown", -- if filetype does not agrees with parser name
	-- }

	-- parser_config.elixir = {
	-- 	install_info = {
	-- 		url = "~/code/tree-sitter-elixir-ananthakumaran",
	-- 		files = { "src/parser.c", "src/scanner.cc" },
	-- 		requires_generate_from_grammar = true,
	-- 	},
	-- 	maintainers = { "@nifoc" },
	-- }
	-- parser_config.eex = {
	-- 	install_info = {
	-- 		url = "https://github.com/connorlay/tree-sitter-eex",
	-- 		files = { "src/parser.c" },
	-- branch = "main"
	-- 	},
	-- 	filetype = "eelixir",
	-- 	maintainers = { "@connorlay" },
	-- }
	-- parser_config.html_eex = {
	-- 	install_info = {
	-- 		url = "https://github.com/rockerBOO/tree-sitter-html-eex",
	-- 		-- url = "/home/rockerboo/code/others/tree-sitter-html-eex",
	-- 		files = { "src/parser.c", "src/scanner.cc" },
	-- 	},
	-- 	filetype = "html_eex",
	-- 	maintainers = { "@connorlay", "@rockerBOO" },
	-- }
	-- vim.treesitter.language.register("eelixir", "eex")
	-- parser_config.embedded_template = {
	-- 	install_info = {
	-- 		url = "https://github.com/tree-sitter/tree-sitter-embedded-template",
	-- 		files = { "src/parser.c" },
	-- 		-- branch = "",
	-- 	},
	-- 	filetype = { "eex", "eelixir" },
	-- }
	-- parser_config.gotmpl = {
	-- 	install_info = {
	-- 		url = "https://github.com/ngalaiko/tree-sitter-go-template",
	-- 		files = { "src/parser.c" },
	-- 	},
	-- 	filetype = "gotmpl",
	-- 	-- used_by = {"gohtmltmpl", "gotexttmpl", "gotmpl", "yaml"}
	-- }
	--
	-- parser_config.crystal = ({
	-- 	install_info = {
	-- 		-- url = "https://github.com/crystal-lang-tools/tree-sitter",
	-- 		--
	-- 		url = "/home/rockerboo/code/others/tree-sitter-crystal",
	-- 		files = { "src/parser.c", "src/scanner.c", "src/unicode.c" },
	--      branch = "main",
	-- 	},
	-- 	filetype = { "crystal", "ecrystal" },
	-- })

	-- parser_config.crystal = ({
	-- 	install_info = {
	-- 		url = "https://github.com/crystal-lang-tools/tree-sitter",
	-- 		files = { "src/parser.c" },
	--      branch = "main",
	-- 	},
	-- 	filetype = { "crystal", "ecrystal" },
	-- })

	-- local ft_to_parser = require"nvim-treesitter.parsers".filetype_to_parsername
	-- ft_to_parser.eelixir = "eex" -- the someft filetype will use the python parser and queries.
	vim.filetype.add({
		extension = {
			gotmpl = "gotmpl",
		},
		pattern = {
			["layouts/.*%.html"] = "gotmpl",
			[".*/templates/.*%.tpl"] = "helm",
			[".*/templates/.*%.ya?ml"] = "helm",
			["helmfile.*%.ya?ml"] = "helm",
		},
	})

	vim.treesitter.query.set(
		"gotmpl",
		"injections",
		"(define_action (text) @html)"
	)
end

return treesitter
