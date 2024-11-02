return {
	"mfussenegger/nvim-dap",
  "nvim-neotest/nvim-nio",
	{
		"rcarriga/nvim-dap-ui",
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
		end,
	},

	{
		"theHamsta/nvim-dap-virtual-text",
		dependencies = { "mfussenegger/nvim-dap" },
	},

{
			"mfussenegger/nvim-dap-python",
			dependencies = { "nvim-telescope/telescope-dap.nvim" },
}
}
