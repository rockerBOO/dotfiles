local completion_with_ts = {
	{ complete_items = { "lsp", "snippet", "ts" } },
	{ complete_items = { "buffer" } },
}

-- let g:completion_chain_complete_list = {
-- 			\'default' : {
-- 			\	'default' : [
-- 			\		{'complete_items' : ['lsp', 'snippet']},
-- 			\		{'mode' : 'file'}
-- 			\	],
-- 			\	'comment' : [],
-- 			\	'string' : []
-- 			\	},
-- 			\'vim' : [
-- 			\	{'complete_items': ['snippet']},
-- 			\	{'mode' : 'cmd'}
-- 			\	],
-- 			\'c' : [
-- 			\	{'complete_items': ['ts']}
-- 			\	],
-- 			\'python' : [
-- 			\	{'complete_items': ['ts']}
-- 			\	],
-- 			\'lua' : [
-- 			\	{'complete_items': ['ts']}
-- 			\	],
-- 			\}

-- Configure the completion chains for completion.nvim
vim.g.completion_chain_complete_list = {
	default = {
		default = { { complete_items = { "lsp", "snippet" }, mode = "file" }, { complete_items = { "buffer" } } },
		typescript = completion_with_ts,
		typescriptreact = completion_with_ts,
	},
}

vim.g.completion_enable_snippet = "vim-vsnip"

vim.g.completion_matching_strategy_list = { "fuzzy", "exact", "substring", "all" }
