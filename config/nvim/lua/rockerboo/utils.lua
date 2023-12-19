local M = {}

-- @param map {{mode, lhs, rhs, opts}, ..}
-- @param mode string 'n' | 'i' | 'v'
-- @param lhs string key to map
-- @param rhs string command to run
M.keymap = function(map)
	map = map or {}
	local opts = map[4] or {}
	vim.keymap.set(map[1], map[2], map[3], opts)
end

-- @param maps list of keymaps
M.keymaps = function(maps)
	for _, m in ipairs(maps) do
		M.keymap(m)
	end
end

-- Skip these servers for formatting
local skip_formatting_lsp = { "diagnosticls", "sumneko_lua", "tsserver" }

-- Format the file using the lsp formatter
M.lsp_format = function()
	-- @param client lsp client
	local format = function(client)
		print(string.format("Formatting for attached client: %s", client.name))

		vim.lsp.buf.formatting_sync(nil, 1000)
	end

	-- Run the function if it passes all the checks
	-- @param client lsp client
	local once = function(client)
		return function(skip, f)
			for _, key in ipairs(skip) do
				if client.name == key then
					return
				end
			end

			f(client)
		end
	end

	-- Run our formatters
	for _, client in pairs(vim.lsp.get_clients()) do
		once(client)(skip_formatting_lsp, format)
	end
end

M.log_to_file = function(logfile)
	return function(log_value)
		local file = io.open(logfile, "a")
		if not file then
			return
		end

		file:write(log_value .. "\n")
		file:close()
	end
end

M.request_refact_file_context = function()
	-- what is the current cursor location
	-- what is the current file
	-- take the preceding part of the file after the current location and add it to the suffix portion
	-- https://codeium.com/blog/why-code-completion-needs-fill-in-the-middle
	-- need to flip the suffix context into the suffix section of the prompt
	--   (move things after the cursor into the suffix section)
	-- <fim_prefix>def x():<fim_suffix>def another_function():\nprint("hello world")<fim_middle>
	-- this lets us keep this context and let the model know to complete at the middle section
	-- must be aware of the context we are sharing as it can be too big for the model
	--   in these cases we might want to reduce the size of the context
	return false
end

M.request_refact = function()
	local endpoint = "http://localhost:8000/infer"

	-- local selection = M.get_text_from_selection(M.get_selection())
	local selection = M.get_visual()
	local result = M.raw_request_refact(endpoint)("<fim_prefix>" .. table.concat(selection, "\n") .. "<fim_middle>")

	if result ~= nil then
	end
end

M.raw_request_refact = function(endpoint)
	return function(prompt)
		local result = nil
		vim.system({
			"curl",
			"--no-progress-meter",
			"-X",
			"POST",
			"-H",
			"Content-Type: application/json",
			"-d",
			vim.json.encode({ prompt = prompt, temperature = 0.4 }),
			endpoint,
		}, {
			text = true,
			stdout = function(err, data)
				if err ~= nil then
					print(err)
				end

				if data ~= nil then
					print("out")
					print(data)
					result = vim.json.decode(data)
					print(result["result"])
				end
			end,
			-- stderr = function(err, data)
			-- 	if err ~= nil then
			-- 		print(err)
			-- 	end
			--
			-- 	print("err")
			-- 	print(data)
			-- end,
		}):wait()

		return result
	end
end

function M.get_visual()
	local _, ls, cs = unpack(vim.fn.getpos("v"))
	local _, le, ce = unpack(vim.fn.getpos("."))

	-- reverse the order if we go from bottom/right to top left
	if ls > le then
		local temp = ls
		ls = le
		le = temp
	end

	print(vim.inspect({ ls, cs }))
	print(vim.inspect({ le, ce }))
	return vim.api.nvim_buf_get_text(0, ls - 1, cs - 1, le - 1, ce, {})
end

function M.get_selection()
	local start = vim.fn.getpos("'<")
	local stop = vim.fn.getpos("'>")

	print(vim.inspect(stop))
	print(vim.inspect(start))
	-- print('start: ' .. start ..  ' stop: ' .. stop)

	return {
		start = {
			row = start[2] - 1,
			col = start[3] - 1,
		},
		stop = {
			row = stop[2] - 1,
			col = stop[3], -- stop col can be vim.v.maxcol which means entire line
		},
	}
end

local COL_ENTIRE_LINE = vim.v.maxcol or 2147483647

-- https://github.com/gsuuon/llm.nvim/blob/main/lua/llm/util.lua#L335C1-L359C4
function M.get_text_from_selection(selection)
	local start_row = selection.start.row
	local start_col = selection.start.col

	if start_col == COL_ENTIRE_LINE then
		start_row = start_row + 1
		start_col = 0
	end

	local success, text = pcall(
		vim.api.nvim_buf_get_text,
		0,
		start_row,
		start_col,
		selection.stop.row,
		selection.stop.col == COL_ENTIRE_LINE and -1 or selection.stop.col,
		{}
	)

	if success then
		return text
	else
		return {}
	end
end

-- https://github.com/gsuuon/llm.nvim/blob/main/lua/llm/util.lua#L361C1-L378C4
function M.set_text(selection, lines)
	local stop_col = selection.stop.col == M.COL_ENTIRE_LINE
			and #assert(
				vim.api.nvim_buf_get_lines(0, selection.stop.row, selection.stop.row + 1, true)[1],
				"No line at " .. tostring(selection.stop.row)
			)
		or selection.stop.col

	vim.api.nvim_buf_set_text(0, selection.start.row, selection.start.col, selection.stop.row, stop_col, lines)
end

return M
