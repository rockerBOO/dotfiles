-- require("compe").setup({
-- 	enabled = true,
-- 	source = {  nvim_lsp = true, nvim_lua = true, vsnip = true, nvim_treesitter = true },
-- })
local lspkind = require("lspkind")
-- local tabnine = require("cmp_tabnine.config")
-- tabnine:setup({
-- 	max_lines = 1000,
-- 	max_num_results = 20,
-- 	sort = true,
-- 	priority = 5000,
-- 	show_prediction_strength = true,
-- })

local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "[LSP]",
	nvim_lua = "[Lua]",
	cmp_tabnine = "[TN]",
	luasnip = "[LuaSnip]",
	path = "[Path]",
	calc = "[calc]",
}

require("cmp").setup({
	completion = {
		autocomplete = false,
	},
	sources = {
		{ name = "cmp_tabnine" },
		{ name = "nvim_lsp" },
		{ name = "luasnip" },
			-- { name = "buffers" },
			-- { name = "nvim_lua" },
	},
	formatting = {
		format = function(entry, vim_item)
			vim_item.kind = lspkind.presets.default[vim_item.kind]
			local menu = source_mapping[entry.source.name]
			if
				entry.source.name == "cmp_tabnine"
				and entry.completion_item.data ~= nil
				and entry.completion_item.data.details ~= nil
			then
				menu = entry.data.details .. " " .. menu
			end
			vim_item.menu = menu
			return vim_item
		end,
	},

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
})
