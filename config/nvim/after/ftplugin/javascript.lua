require("plugin.jester").mappings()

vim.keymap.set("n", "<leader>rr", function()
	local file = vim.fn.expand("%") -- Get the current file name
	local escaped_file = vim.fn.shellescape(file)
	vim.cmd("new")
	vim.cmd("terminal node " .. escaped_file)
	vim.api.nvim_feedkeys("i", "n", false)
end, { desc = "Execute javascript file with nodejs" })
