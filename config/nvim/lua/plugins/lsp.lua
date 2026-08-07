return {
	"neovim/nvim-lspconfig",
	-- { dir = "~/code/symbols-outline.nvim" },
	{
		"hedyhli/outline.nvim",
		config = function()
			-- Example mapping to toggle outline
			vim.keymap.set(
				"n",
				"<leader>o",
				"<cmd>Outline<CR>",
				{ desc = "Toggle Outline" }
			)

			require("outline").setup({
				outline_window = {
					width = 35,
				},
				preview_window = {
					auto_preview = false,
				},
			})
		end,
	},
	"onsails/lspkind-nvim",

	-- {
	-- 	"hrsh7th/cmp-nvim-lsp",
	-- 	dependencies = "onsails/lspkind-nvim",
	-- },
	--
	-- {
	-- 	"hrsh7th/cmp-nvim-lsp-signature-help",
	-- 	dependencies = { "hrsh7th/nvim-cmp" },
	-- },
	{
		"smjonas/inc-rename.nvim",
		config = function()
			require("inc_rename").setup({})
		end,
	},
	{
		"lopi-py/luau-lsp.nvim",
		opts = {
			server = {
				path = "/home/rockerboo/Downloads/luau-lsp",
			},
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
	},
}
