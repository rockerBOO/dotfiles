vim.lsp.start({
	name = "pest-language-server",
	cmd = { "pest-language-server" },
	root_dir = vim.fs.dirname(vim.fs.find({ "Cargo.toml" }, { upward = true })[1]),
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function()
		vim.api.nvim_create_autocmd("BufWrite", {
			callback = function()
				vim.lsp.buf.format()
			end,
		})
	end,
	buffer = 0,
})

-- Allow access to run the last runnable
vim.keymap.set("n", "<leader>tt", function()
	require("rust-tools").cached_commands.execute_last_runnable()
end, { buffer = 0 })
