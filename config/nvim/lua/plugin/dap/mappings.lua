local dap = require("dap")
local n = "n"
local mappings = {}
local silent = { silent = true }
local maps = {
	-- { n, "<F5>", dap.continue, silent },
	{ n, "<Leader>dk", dap.continue, silent },
	{ n, "<Leader>ddt", dap.terminate, silent },
	{ n, "<Leader>do", dap.step_over, silent },
	{ n, "<Leader>di", dap.step_into, silent },
	-- { n, "<Leader>d", dap.step_out, silent },
	{ n, "<leader>b", dap.toggle_breakpoint, silent },
	{ n, "<leader><c-b>", dap.clear_breakpoints, silent },
	{
		n,
		"<leader>B",
		function()
			dap.toggle_breakpoint(vim.fn.input("Breakpoint condition"))
		end,
		silent,
	},
	{
		n,
		"<leader>lp",
		function()
			dap.set_breakpoint(nil, nil, vim.fn.input("Log point message"))
		end,
		silent,
	},
	{
		n,
		"<leader>dr",
		dap.repl.open,
		silent,
	},
	{ n, "<Leader>dc", dap.run_to_cursor, silent },
	{ n, "<Leader>dl", dap.run_last, silent },
	{ n, "<Leader>du", dap.up, silent },
	{ n, "<Leader>dd", dap.down, silent },
	{ n, "<Leader>db", dap.step_back, silent },
	{
		n,
		"<Leader>K",
		function()
			local api = vim.api
			local function new_buf()
				local buf = api.nvim_create_buf(false, true)
				api.nvim_buf_set_option(buf, "modifiable", false)
				api.nvim_buf_set_option(buf, "buftype", "nofile")
				api.nvim_buf_set_option(buf, "modifiable", false)
				api.nvim_buf_set_keymap(
					buf,
					"n",
					"<CR>",
					"<Cmd>lua require('dap.ui').trigger_actions({ mode = 'first' })<CR>",
					{}
				)
				api.nvim_buf_set_keymap(
					buf,
					"n",
					"a",
					"<Cmd>lua require('dap.ui').trigger_actions()<CR>",
					{}
				)
				api.nvim_buf_set_keymap(
					buf,
					"n",
					"o",
					"<Cmd>lua require('dap.ui').trigger_actions()<CR>",
					{}
				)
				api.nvim_buf_set_keymap(
					buf,
					"n",
					"<2-LeftMouse>",
					"<Cmd>lua require('dap.ui').trigger_actions()<CR>",
					{}
				)
				return buf
			end
			local widgets = require("dap.ui.widgets")

			local new_cursor_anchored_float_win = function(buf)
				vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
				vim.api.nvim_buf_set_option(buf, "filetype", "dap-float")
				local opts = vim.lsp.util.make_floating_popup_options(
					50,
					30,
					{ border = false }
				)
				local win = vim.api.nvim_open_win(buf, true, opts)
				vim.api.nvim_win_set_option(win, "scrolloff", 0)
				return win
			end

			local widget =
				widgets.builder(widgets.expression).new_buf(
					new_buf
				).new_win(
					widgets.with_resize(
						new_cursor_anchored_float_win
					)
				).build()

			widget.open()
			-- widgets.hover("<cexpr>", { border = false })
		end,
		silent,
	},
}

mappings.setup = function()
	-- Apply the keymaps
	require("rockerboo.utils").keymaps(maps)
end

-- 3F79Z

return mappings
