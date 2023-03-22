-- require("compe").setup({
-- 	enabled = true,
-- 	source = {  nvim_lsp = true, nvim_lua = true, vsnip = true, nvim_treesitter = true },
-- })
local lspkind = require("lspkind")
local cmp = require("cmp")

local source_mapping = {
	buffer = "[Buffer]",
	nvim_lsp = "LSP",
	nvim_lua = "[Lua]",
	treesitter = "Tree",
	cmp_tabnine = "TN",
	luasnip = "[LuaSnip]",
	path = "[Path]",
	calc = "[calc]",
}

local t = function(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end

require("cmp").setup({
	mapping = {
		["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-4), { "i", "c" }),
		["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(4), { "i", "c" }),
		["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
		["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
		["<C-n>"] = cmp.mapping({
			c = function()
				if cmp.visible() then
					cmp.select_next_item({
						behavior = cmp.SelectBehavior.Select,
					})
				else
					vim.api.nvim_feedkeys(t("<Down>"), "n", true)
				end
			end,
			i = function(fallback)
				if cmp.visible() then
					cmp.select_next_item({
						behavior = cmp.SelectBehavior.Select,
					})
				else
					fallback()
				end
			end,
		}),
		["<C-p>"] = cmp.mapping({
			c = function()
				if cmp.visible() then
					cmp.select_prev_item({
						behavior = cmp.SelectBehavior.Select,
					})
				else
					vim.api.nvim_feedkeys(t("<Up>"), "n", true)
				end
			end,
			i = function(fallback)
				if cmp.visible() then
					cmp.select_prev_item({
						behavior = cmp.SelectBehavior.Select,
					})
				else
					fallback()
				end
			end,
		}),
		["<C-e>"] = cmp.mapping({
			i = cmp.mapping.abort(),
			c = cmp.mapping.close(),
		}),
		["<CR>"] = cmp.mapping.confirm({ select = false }),
	},
	sources = {
		{ name = "nvim_lsp" },
		{ name = "cmp_tabnine" },
		{ name = "luasnip" },
		{ name = "treesitter" },
		{ name = "nvim_lsp_signature_help" },
		-- { name = "buffers" },
		-- { name = "nvim_lua" },
	},
	-- formatting = {
	-- 	format = function(entry, vim_item)
	-- 		vim_item.kind = lspkind.presets.default[vim_item.kind]
	-- 		local menu = source_mapping[entry.source.name]
	-- 		if
	-- 			entry.source.name == "cmp_tabnine"
	-- 			and entry.completion_item.data ~= nil
	-- 			and entry.completion_item.data.details ~= nil
	-- 		then
	-- 			menu = entry.data.details .. " " .. menu
	-- 		end
	-- 		vim_item.menu = menu
	-- 		return vim_item
	-- 	end,
	-- },
	experimental = {
		native_menu = false,
		ghost_text = true,
	},

	snippet = {
		expand = function(args)
			require("luasnip").lsp_expand(args.body)
		end,
	},
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = { "sql", "mysql", "plsql" },
	callback = function()
		require("cmp").setup.buffer({
			sources = { { name = "vim-dadbod-completion" } },
		})
	end,
})
