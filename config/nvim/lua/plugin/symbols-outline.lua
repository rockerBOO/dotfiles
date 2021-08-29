local setup = function()
	vim.g.symbols_outline = { auto_preview = false, width = 30 }
	vim.cmd("highlight! link FocusedSymbol Search")
end

return { setup = setup }
