return {
	setup = function()
		local dap = require("dap")

		dap.adapters.firefox = {
			type = "executable",
			command = "yarn",
			args = {
				"node",
				os.getenv("HOME") .. "/build/vscode-firefox-debug/dist/adapter.bundle.js",
			},
		}

		dap.adapters.node2 = {
			type = "executable",
			command = "yarn",
			args = {
				"node",
				os.getenv("HOME") .. "/build/vscode-node-debug2/out/src/nodeDebug.js",
			},
		}

		dap.configurations.typescript = {
			name = "Debug with Firefox",
			type = "firefox",
			request = "launch",
			reAttach = true,
			sourceMaps = true,
			url = "http://localhost:6969",
			webRoot = "${workspaceFolder}",
			firefoxExecutable = "/usr/bin/firefox",
		}

		dap.configurations.typescriptreact = {
			name = "Debug with Firefox",
			type = "firefox",
			request = "launch",
			reAttach = true,
			sourceMaps = true,
			url = "http://localhost:6969",
			webRoot = "${workspaceFolder}",
			firefoxExecutable = "/usr/bin/firefox",
		}

		dap.configurations.javascript = {
			name = "Debug with Firefox",
			type = "firefox",
			request = "launch",
			reAttach = true,
			sourceMaps = true,
			url = "http://localhost:6969",
			webRoot = "${workspaceFolder}",
			firefoxExecutable = "/usr/bin/firefox",
		}

		dap.configurations.typescriptreact = {
			{
				name = "Launch",
				type = "node2",
				request = "launch",
				program = "${file}",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				protocol = "inspector",
				console = "integratedTerminal",
			},
			{
				-- For this to work you need to make sure the node process is started with the `--inspect` flag.
				name = "Attach to process",
				type = "node2",
				request = "attach",
				processId = require("dap.utils").pick_process,
			},
		}

    -- lldb/rust
		dap.adapters.lldb = {
			type = "executable",
			command = "/usr/bin/lldb-vscode", -- adjust as needed
			name = "lldb",
		}

		dap.configurations.rust = {
			{
				name = "Launch",
				type = "lldb",
				request = "launch",
				program = function()
					return vim.fn.input(
						"Path to executable: ",
						vim.fn.getcwd() .. "/",
						"file"
					)
				end,
				cwd = "${workspaceFolder}",
				stopOnEntry = false,
				args = {},

				-- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
				--
				--    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
				--
				-- Otherwise you might get the following error:
				--
				--    Error on launch: Failed to attach to the target process
				--
				-- But you should be aware of the implications:
				-- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
				runInTerminal = false,
			},
		}

		-- setup extensions
		require("nvim-dap-virtual-text").setup()
    require('plugin.dap.mappings').setup()
	end,
}
