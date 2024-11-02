local function list_files(directory, callback)
	local req, err, name = vim.uv.fs_scandir(directory)
	if not req then
		print("Error opening directory: " .. err)
		return
	end

	local files = {}

	coroutine.wrap(function()
		while true do
			local name, type = vim.uv.fs_scandir_next(req)
			if not name then
				break
			end
			table.insert(files, name)
			print(name, type)
		end
		callback(files)
	end)()
end

local voices = function()
	-- local pickers = require("telescope.pickers")
	-- local finders = require("telescope.finders")
	-- local sorters = require("telescope.sorters")
	local themes = require("telescope.themes")
	-- local action_state = require("telescope.actions.state")
	-- local conf = require("telescope.config").values

	list_files("/home/rockerboo/code/others/VALL-E-X/customs", function(files)
		local filename = vim.fn.expand("%")
		local opts = themes.get_dropdown({})

		vim.ui.select(files, { prompt = "Voices" }, function(choice)
			if choice == nil then
				return
			end

			vim.cmd("sp")
			-- Get the handle of the current buffer in the new window
			local new_buf = vim.api.nvim_get_current_buf()

			-- Set the current buffer in the new window
			vim.api.nvim_set_current_buf(new_buf)

			vim.cmd(
				'term echo "'
					.. choice:gsub("%.npz", "")
					.. '" && cd /home/rockerboo/code/others/VALL-E-X && source .env && python test.py --prompt "'
					.. choice:gsub("%.npz", "")
					.. '" --file '
					.. filename
					.. " && audio-player -v 0.2 completed-compiling.wav"
			)
		end)
		-- 	pickers
		-- 		.new(opts, {
		-- 			prompt_title = "Voices",
		-- 			finder = finders.new_table({
		-- 				results = files,
		-- 				entry_maker = opts.entry_maker,
		-- 			}),
		-- 			previewer = conf.grep_previewer(opts),
		-- 			sorter = sorters.highlighter_only(opts),
		-- 			attach_mappings = function(prompt_bufnr, map)
		-- 				map("i", "<CR>", function()
		-- 					local selection = action_state.get_selected_entry()
		-- 					vim.cmd("sp")
		-- 					-- Get the handle of the current buffer in the new window
		-- 					local new_buf = vim.api.nvim_get_current_buf()
		--
		-- 					-- Set the current buffer in the new window
		-- 					vim.api.nvim_set_current_buf(new_buf)
		--
		-- 					vim.cmd(
		-- 						'term echo "'
		-- 							.. selection[1]:gsub("%.npz", "")
		-- 							.. '" && cd /home/rockerboo/code/others/VALL-E-X && source .env && python test.py --prompt "'
		-- 							.. selection[1]:gsub("%.npz", "")
		-- 							.. '" --file '
		-- 							.. filename
		-- 							.. " && audio-player -v 0.2 completed-compiling.wav"
		-- 					)
		-- 				end)
		-- 				return true
		-- 			end,
		-- 		})
		-- 		:find()
	end)
end

local save_voice = function()
	local datetime = vim.fn.strftime("%Y-%m-%d-%H%M%S")

	vim.system({ "cat", "meta.json", "|", "jq", "-r", "'.voice'" }, {
		stdout = function(err, data)
			if err ~= nil then
				print(err)
			elseif data == nil then
				print("unable to get voice from meta.json")

				vim.system({
					"cp",
					"/home/rockerboo/code/others/VALL-E-X/completed-compiling.wav",
					"/home/rockerboo/code/others/VALL-E-X/long/"
						.. datetime
						.. ".wav",
				})
			else
				vim.system({
					"cp",
					"/home/rockerboo/code/others/VALL-E-X/completed-compiling.wav",
					"/home/rockerboo/code/others/VALL-E-X/long/"
						.. datetime
						.. "-"
						.. data
						.. ".wav",
				})
			end
		end,
	})
end

return { voices = voices, save_voice = save_voice }
