return {
	setup = function()
		local dap = require("dap")

		-- ADAPTERS
		-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

		dap.adapters.node2 = function(cb, config)
			if config.preLaunchTask then
				vim.fn.system(config.preLaunchTask)
			end
			local adapter = {
				type = "executable",
				command = "node",
				args = {
					"/mnt/900/builds/vscode-node-debug2/out/src/nodeDebug.js",
				},
			}
			cb(adapter)
		end

		-- WIP does not execute
		dap.adapters.deno = function(cb)
			local adapter = {
				type = "executable",
				command = "deno",
			}
			cb(adapter)
		end

		dap.adapters.firefox = {
			type = "executable",
			command = "node",
			args = {
				os.getenv("HOME")
					.. "/build/vscode-firefox-debug/dist/adapter.bundle.js",
			},
		}

		dap.adapters.yarn = {
			type = "executable",
			command = "yarn",
			args = {
				"run",
				"--inspect-brk",
				"/mnt/900/builds/vscode-node-debug2/out/src/nodeDebug.js",
			},
		}

		dap.adapters.yarn_jest = {
			type = "executable",
			command = "yarn",
			args = {
				"run",
				"--inspect-brk",
				"jest",
			},
		}

		dap.adapters.yarn_firefox = {
			type = "executable",
			command = "yarn",
			args = {
				"node",
				"--inspect-brk",
				os.getenv("HOME")
					.. "/build/vscode-firefox-debug/dist/adapter.bundle.js",
			},
		}

		-- lldb/rust
		dap.adapters.lldb = {
			type = "executable",
			command = "/usr/bin/lldb-vscode", -- adjust as needed
			name = "lldb",
		}

		dap.adapters.nlua = function(callback, config)
			callback({
				type = "server",
				host = config.host,
				port = config.port,
			})
		end

		-- LAUNCHERS
		-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

		local nlua = {
			type = "nlua",
			request = "attach",
			name = "Attach to running Neovim instance",
			host = function()
				local value = vim.fn.input("Host [127.0.0.1]: ")
				if value ~= "" then
					return value
				end
				return "127.0.0.1"
			end,
			port = function()
				local val = tonumber(vim.fn.input("Port: "))
				assert(val, "Please provide a port number")
				return val
			end,
		}

		local firefox = {
			name = "Debug with Firefox",
			type = "firefox",
			request = "launch",
			reAttach = true,
			sourceMaps = true,
			url = "http://localhost:6969",
			webRoot = "${workspaceFolder}",
			firefoxExecutable = "/usr/bin/firefox",
		}

		local node2 = {
			name = "Launch node",
			type = "node2",
			request = "launch",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
		}

		local yarn = {
			name = "Launch node",
			type = "yarn",
			request = "launch",
			program = "${file}",
			cwd = vim.fn.getcwd(),
			sourceMaps = true,
			protocol = "inspector",
			console = "integratedTerminal",
		}

		local tauri_dev = {
			type = "lldb",
			request = "launch",
			name = "Tauri Development Debug",
			args = {
				"cargo",
				"build",
				"--manifest-path=./src-tauri/Cargo.toml",
				"--no-default-features",
			},
			-- task for the `beforeDevCommand` if used, must be configured in `.vscode/tasks.json`
			-- preLaunchTask = "ui:dev"
		}

		local tauri_prod = {
			type = "lldb",
			request = "launch",
			name = "Tauri Production Debug",
			args = {
				"cargo",
				"build",
				"--release",
				"--manifest-path=./src-tauri/Cargo.toml",
			},
			-- // task for the `beforeBuildCommand` if used, must be configured in `.vscode/tasks.json`
			-- "preLaunchTask": "ui:build"
		}

		local lldb = {
			name = "Launch lldb",
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
		}

		-- WIP does not launch properly, maybe needs a different runtime args
		local deno = {
			name = "Launch Deno",
			type = "deno",
			request = "launch",
			cwd = "${workspaceFolder}",
			runtimeExecutable = "deno",
			runtimeArgs = { "run", "--inspect-brk", "-A", "${file}" },
			port = 9229,
		}

		-- ADAPTERS
		-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

		local node_attach = {
			-- For this to work you need to make sure the node process is started with the `--inspect` flag.
			name = "Attach to node process",
			type = "node2",
			request = "attach",
			processId = require("dap.utils").pick_process,
		}

		-- CONFIGURATIONS
		-- =-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-

		dap.configurations.javascript = { firefox, node2, deno, node_attach }
		dap.configurations.javascriptreact = {
			firefox,
			node2,
			deno,
			node_attach,
		}

		dap.configurations.typescript = { firefox, node2, deno, node_attach }
		dap.configurations.typescriptreact = {
			node2,
			firefox,
			deno,
			node_attach,
		}

		dap.configurations.rust = {
			lldb,
			tauri_dev,
			tauri_prod,
		}

		dap.configurations.lua = {
			nlua,
		}

		-- au FileType dap-repl lua require('dap.ext.autocompl').attach()

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "dap-repl",
			callback = function()
				require("dap.ext.autocompl").attach()
			end,
		})

		-- setup extensions
		-- require("nvim-dap-virtual-text").setup()
		require("plugin.dap.mappings").setup()
	end,
}
