vim.keymap.set("n", "<leader>rr", function()
	vim.cmd("new")

	vim.cmd("terminal /home/rockerboo/code/others/gleam/target/release/gleam run")
	-- vim.api.nvim_feedkeys("i", "n", false)
end, { desc = "Run a gleam program" })

