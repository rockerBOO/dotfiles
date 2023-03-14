local setup = function()
	require("symbols-outline").setup({
		auto_preview = false,
		width = 35,
	})
	vim.cmd("highlight! link FocusedSymbol Search")
	-- vim.api.nvim_create_autocmd("FileType", {
	-- 	pattern = "Outline",
	-- 	callback = function()
	-- 		vim.opt_local.signcolumn = false
	-- 	end,
	-- })

	vim.cmd([[autocmd FileType Outline setlocal signcolumn=no]])
end

return { setup = setup }
