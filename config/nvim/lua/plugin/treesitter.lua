local treesitter = {}

treesitter.setup = function()
	require("nvim-treesitter.configs").setup({
		-- modules and its options go here
		highlight = { enable = true },
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
		textobjects = { enable = true },
		playground = { enable = true, disable = {}, updatetime = 25, persist_queries = false },
		additional_vim_regex_highlighting = false,
		node_movement = {
			keymaps = {
				move_up = "<c-g>",
				move_down = "<m-j>",
				move_left = "<a-h>",
				move_right = "<a-l>",
				swap_left = "<s-a-h>", -- will only swap when one of "swappable_textobjects" is selected
				swap_right = "<s-a-l>",
				select_current_node = "<leader><cr>",
			},
			swappable_textobjects = { "@function.outer", "@parameter.inner", "@statement.outer" },
			allow_switch_parents = true, -- more craziness by switching parents while staying on the same level, false prevents you from accidentally jumping out of a function
			allow_next_parent = true, -- more craziness by going up one level if next node does not have children
		},
	})

	local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
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
			url = "~/code/tree-sitter-elixir", -- local path or git repo
			files = { "src/parser.c" },
		},
		filetype = "elixir", -- if filetype does not agrees with parser name
		used_by = {}, -- additional filetypes that use this parser
	}
end

return treesitter
