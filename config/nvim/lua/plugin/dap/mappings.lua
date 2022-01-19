local dap = require("dap")
local n = "n"
local mappings = {}
local silent = { silent = true }
local maps = {
	{ n, "<F5>", dap.continue, silent },
	{ n, "<F10>", dap.step_over, silent },
	{ n, "<F11>", dap.step_into, silent},
	{ n, "<F12>", dap.step_out, silent },
	{ n, "<leader>b", dap.toggle_breakpoint, silent },
	{
		n,
		"<leader>B",
		function()
			dap.toggle_breakpoint(vim.fn.input("Breakpoint condition"))
		end,
    silent
	},
	{
		n,
		"<leader>lp",
		function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log point message"))
		end,
    silent
	},
	{
		n,
		"<leader>dr",
		dap.repl.open,
    silent
	},
  { n, "<Leader>dl", dap.run_last, silent }
}


mappings.setup = function()
	-- Apply the keymaps
	require("rockerboo.utils").keymaps(maps)
end

return mappings
