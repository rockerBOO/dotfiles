return {
	setup = function()
		require("formatter").setup({
			filetype = {
				gleam = {
					-- prettier
					function()
						return {
							exe = "gleam",
							args = { "format", "--stdin" },
							stdin = true,
						}
					end,
				},

				lua = {
					function()
						return {
							exe = "stylua",
							args = {
								"-",
							},
							stdin = true,
						}
					end,
				},
				python = {
					-- Configuration for psf/black
					function()
						return {
							exe = "black", -- this should be available on your $PATH
							args = { "-" },
							stdin = true,
						}
					end,
				},
			},
		})

		vim.keymap.set("n", "<leader>aa", ":Format<cr>", { silent = true })
	end,
}
