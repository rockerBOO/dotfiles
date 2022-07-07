local util = require("formatter.util")

local local_prettier_d_slim = function()
	return {
		exe = "yarn prettier_d_slim",
		args = { util.escape_path(util.get_current_buffer_file_path()) },
		stdin = true,
	}
end

return {
	setup = function()
		require("formatter").setup({
			filetype = {
				gleam = {
					function()
						return {
							exe = "gleam",
							args = { "format", "--stdin" },
							stdin = true,
						}
					end,
				},

				lua = { require("formatter.filetypes.lua").stylua },

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
				typescriptreact = {

					require("formatter.filetypes.javascript").prettierd,
					local_prettier_d_slim,
				},
				typescript = {
					local_prettier_d_slim,
				},
				html = { require("formatter.filetypes.html").prettierd },
				javascript = {
					require("formatter.filetypes.javascript").prettierd,
				},
				markdown = { require("formatter.filetypes.html").prettierd },
				rust = { require("formatter.filetypes.rust").rustfmt },
			},
		})

		vim.keymap.set("n", "<leader>aa", ":Format<cr>", { silent = true })
	end,
}
