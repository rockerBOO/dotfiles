return {
	"mfussenegger/nvim-dap",
	"nvim-neotest/nvim-nio",
	{
		"rcarriga/nvim-dap-ui",
		lazy = true,
		dev = true,
		dir = "~/code/others/nvim-dap-ui",
		dependencies = {
			"mfussenegger/nvim-dap",
			"nvim-neotest/nvim-nio",
		},
		config = function()
			require("dapui").setup({
				layouts = {
					{
						elements = {
							"repl",
							"console",
						},
						size = 0.25, -- 25% of total lines
						position = "bottom",
					},
					{
						elements = {
							-- Elements can be strings or table with id and size keys.
							{ id = "scopes", size = 0.25 },
							"breakpoints",
							"stacks",
							"watches",
						},
						size = 40, -- 40 columns
						position = "left",
					},
				},
			})

			local dap, dapui = require("dap"), require("dapui")
			dap.listeners.after.event_initialized["dapui_config"] = function()
				dapui.open()
			end
			dap.listeners.before.event_terminated["dapui_config"] = function()
				dapui.close()
			end
			dap.listeners.before.event_exited["dapui_config"] = function()
				dapui.close()
			end
		end,
	},

	{
		"theHamsta/nvim-dap-virtual-text",
		lazy = true,
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("nvim-dap-virtual-text").setup()
		end,
	},

	{
		"mfussenegger/nvim-dap-python",
		dependencies = { "nvim-telescope/telescope-dap.nvim" },
		config = function()
			require("dap-python").setup("uv")
			-- require("dap-python").setup(
			-- 	"/mnt/900/builds/miniconda3/envs/prs/bin/python"
			-- )

			table.insert(require("dap").configurations.python, {
				type = "python",
				request = "launch",
				name = "My custom launch configuration",
				program = "${file}",
				justMyCode = false,
				-- ... more options, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings
			})
			-- setup extensions
		end,
	},
}
