local M = {}

M.attach_keymaps = function()
	vim.keymap.set("n", "<leader>rr", function()
		local file = vim.fn.expand("%") -- Get the current file name
		local escaped_file = vim.fn.shellescape(file)
		vim.cmd("new")
    vim.cmd("terminal npx tsx " .. escaped_file)
		-- vim.cmd("terminal bun " .. escaped_file)
		vim.api.nvim_feedkeys("i", "n", false)
	end, { desc = "Execute javascript file with nodejs" })

	local bufnr = vim.api.nvim_get_current_buf()

	vim.keymap.set("n", "<leader>tt", function()
		print("running test")
		require("neotest").run.run()
	end, { desc = "Run the nearest test", buffer = bufnr })

	vim.api.nvim_set_keymap(
		"n",
		"<leader>twf",
		"<cmd>lua require('neotest').run.run({ vim.fn.expand('%'), vitestCommand = 'vitest --watch' })<cr>",
		{ desc = "Run Watch File" }
	)
end

return M
