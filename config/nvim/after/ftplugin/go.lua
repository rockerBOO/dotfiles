vim.keymap.set("n", "<leader>tt", function()
	require("neotest").run.run()
end, { desc = "Run the nearest test" })

vim.keymap.set("n", "<leader>tl", function()
	require("neotest").run.run_last()
end, { desc = "Run the last test" })
