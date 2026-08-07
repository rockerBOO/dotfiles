return {
	{
		"folke/lazydev.nvim",
		ft = "lua", -- only load on lua files
		opts = {
			library = {
				-- See the configuration section for more details
				-- Load luvit types when the `vim.uv` word is found
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	{ "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings
	-- { -- optional cmp completion source for require statements and module annotations
	--   "hrsh7th/nvim-cmp",
	--   opts = function(_, opts)
	--     opts.sources = opts.sources or {}
	--     table.insert(opts.sources, {
	--       name = "lazydev",
	--       group_index = 0, -- set group index to 0 to skip loading LuaLS completions
	--     })
	--   end,
	-- },
	-- { -- optional blink completion source for require statements and module annotations
	--   "saghen/blink.cmp",
	--   opts = {
	--     sources = {
	--       -- add lazydev to your completion providers
	--       completion = {
	--         enabled_providers = { "lsp", "path", "snippets", "buffer", "lazydev" },
	--       },
	--       providers = {
	--         -- dont show LuaLS require statements when lazydev has items
	--         lsp = { fallback_for = { "lazydev" } },
	--         lazydev = { name = "LazyDev", module = "lazydev.integrations.blink" },
	--       },
	--     },
	--   },
	-- }
}
