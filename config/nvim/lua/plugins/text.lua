return {
	{
		"lervag/vimtex",
		lazy = false,
		init = function()
			-- VimTeX configuration goes here, e.g.
			vim.g.vimtex_view_method = "zathura"
		end,
	},
	{
		"pxwg/math-conceal.nvim",
		event = "VeryLazy",
		main = "math-conceal",
		build = "cargo build --release --manifest-path service/Cargo.toml", -- required for graphical equation conceal
		--- @type LaTeXConcealOptions
		opts = {
			conceal = {
				"greek",
				"script",
				"math",
				"font",
				"delim",
				"phy",
			},
			ft = { "plaintex", "tex", "context", "bibtex", "markdown", "typst" },
			opt = {
				conceallevel = 2,
				concealcursor = "n",
			},
			image = {
				enabled = true, -- set true to enable graphical equation conceal
			},
		},
	},
	{
		"f3fora/nvim-texlabconfig",
		config = function()
			-- Default config
			local config = {
				cache_activate = true,
				cache_filetypes = { "tex", "bib" },
				cache_root = vim.fn.stdpath("cache"),
				reverse_search_start_cmd = function()
					return true
				end,
				reverse_search_edit_cmd = vim.cmd.edit,
				reverse_search_end_cmd = function()
					return true
				end,
				file_permission_mode = 438,
			}

			require("texlabconfig").setup(config)
		end,
		ft = { "tex", "bib" }, -- Lazy-load on filetype
		-- build = "go build",
		build = "go build -o ~/.bin/", -- if e.g. ~/.bin/ is in $PATH
	},
}
