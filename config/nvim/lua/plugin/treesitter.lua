local treesitter = {}

treesitter.setup = function()
	require("nvim-treesitter.configs").setup({
		-- modules and its options go here
		highlight = { enable = true },
		context_commentstring = {
			enable = true,
		},
		incremental_selection = {
			enable = true,
			keymaps = {
				init_selection = "gnn",
				node_incremental = "gnr",
				scope_incremental = "gnc",
				node_decremental = "gnm",
			},
		},
		indent = {
			enable = true,
		},
		textsubjects = {
			enable = true,
			keymaps = {
				["."] = "textsubjects-smart",
				[";"] = "textsubjects-container-outer",
			},
		},
		-- textobjects = {
		-- 	enable = true,
		-- 	select = {
		-- 		enable = true,
		-- 		keymaps = {
		-- 			["af"] = "@function.outer",
		-- 			["if"] = "@function.inner",
		-- 			["ac"] = "@class.outer",
		-- 			["ic"] = "@class.inner",
		-- 		},
		-- 	},
		-- },
		playground = {
			enable = true,
			disable = {},
			updatetime = 25,
			persist_queries = false, 
		},
		additional_vim_regex_hjighlighting = false,
	})

	local parser_config =
		require("nvim-treesitter.parsers").get_parser_configs()

	parser_config.gleam = {
		install_info = {
			url = "~/code/tree-sitter-gleam-gg", -- local path or git repo
			files = { "src/parser.c" },
		},
		filetype = "gleam", -- if filetype does not agrees with parser name
		used_by = {}, -- additional filetypes that use this parser
	}

	parser_config.markdown = {
		install_info = {
			url = "~/code/tree-sitter-markdown", -- local path or git repo
			files = { "src/parser.c" },
		},
		filetype = "markdown", -- if filetype does not agrees with parser name
		used_by = {}, -- additional filetypes that use this parser
	}

	parser_config.elixir = {
		install_info = {
			url = "~/code/tree-sitter-elixir-ananthakumaran",
			files = { "src/parser.c", "src/scanner.cc" },
			requires_generate_from_grammar = true,
		},
		maintainers = { "@nifoc" },
	}
	table.insert(parser_config.html.used_by, "ejs")
end

return treesitter
