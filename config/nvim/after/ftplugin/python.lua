-- vim.keymap.set(
-- 	"n",
-- 	"<leader>rr",
-- 	-- "<cmd>:sp<CR>:term python %<CR>",
-- 	"<cmd>:sp<CR>:term poetry run python %<CR>",
-- 	{ silent = true }
-- )

vim.keymap.set("n", "<leader>rr", function()
	local file = vim.fn.expand("%") -- Get the current file name
	local escaped_file = vim.fn.shellescape(file)
	vim.cmd("new")
	vim.cmd("terminal source .env && python " .. escaped_file)
	vim.api.nvim_feedkeys("i", "n", false)
end, { desc = "Execute python file with .env" })

vim.keymap.set("n", "<leader>tt", function()
	require("neotest").run.run()
end, { desc = "Run the nearest test" })

vim.keymap.set("n", "<leader>tl", function()
	require("neotest").run.run_last()
end, { desc = "Run the last test" })

vim.keymap.set("n", "<leader>tw", function()
	require("neotest").watch.watch()
end, { desc = "Run the watch" })

vim.keymap.set("n", "<leader>ra", function()
	vim.cmd(":sp<CR>")
	vim.cmd(":term accelerate launch %<CR>")
end, {})
