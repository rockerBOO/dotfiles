return { "neovim/nvim-lspconfig",
  { dir = "~/code/symbols-outline.nvim" },
  "onsails/lspkind-nvim",

  {
			"hrsh7th/cmp-nvim-lsp",
			dependencies = "onsails/lspkind-nvim",
  },

  {
			"hrsh7th/cmp-nvim-lsp-signature-help",
			dependencies = { "hrsh7th/nvim-cmp" },
  }
}
