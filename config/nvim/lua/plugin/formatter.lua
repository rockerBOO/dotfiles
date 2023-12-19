local util = require("formatter.util")
local defaults = require("formatter.defaults")

local local_prettier_d_slim = function()
	print(vim.inspect({
		exe = "yarn",
		args = {
			"prettier_d_slim",
			"--stdin",
			"--stdin-filepath",
			util.get_current_buffer_file_path(),
		},
		stdin = true,
	}))
	return {
		exe = "yarn",
		args = {
			"prettier_d_slim",
			"--stdin",
			"--stdin-filepath",
			util.get_current_buffer_file_path(),
		},
		stdin = true,
	}
end

local local_prettier = function(parser)
	if not parser then
		return {
			exe = "yarn",
			args = {
				"run",
				"prettier",
				"--stdin-filepath",
				util.get_current_buffer_file_path(),
			},
			stdin = true,
			try_node_modules = true,
		}
	end
	return {
		exe = "yarn",
		args = {
			"run",
			"prettier",
			"--stdin-filepath",
			util.get_current_buffer_file_path(),
			"--parser",
			parser,
		},
		stdin = true,
		try_node_modules = true,
	}
end

local rome = function()
	return {
		exe = "yarn",
		args = {
			"rome",
			"format",
			"--stdin-file-path",
			string.format('"%s"', util.escape_path(util.get_current_buffer_file_path())),
		},
		stdin = true,
	}
end

local prettier_d_slim = function()
	return {
		exe = "prettier_d_slim",
		args = {
			"--stdin",
			"--stdin-filepath",
			util.get_current_buffer_file_path(),
		},
		stdin = true,
	}
end

local nginxfmt = function()
	return {
		exe = "/mnt/900/builds/nginx-config-formatter/nginxfmt.py",
		args = {
			"-",
			-- util.escape_path(util.get_current_buffer_file_path()),
		},
		stdin = true,
	}
end

-- Removes extra new lines between sections
local google_yamlfmt = function()
	return {
		exe = "yamlfmt",
		args = {
			"-",
		},
		stdin = true,
	}
end

local gdformat = function()
	return {
		exe = "gdformat",
		stdin = false,
	}
end

return {
	setup = function()
		---@diagnostic disable-next-line: redundant-parameter
		require("formatter").setup({
			logging = true,
			filetype = {
				sh = {
					require("formatter.filetypes.sh").shfmt,
				},
				bash = {
					require("formatter.filetypes.sh").shfmt,
				},
				gleam = {
					function()
						return {
							exe = "gleam",
							args = { "format", "--stdin" },
							stdin = true,
						}
					end,
				},
				gdscript = {
					gdformat,
				},

				elixir = {
					-- function()
					-- 	return {
					-- 		exe = "mix",
					-- 		args = {
					-- 			"format",
					-- "-",
					-- 		},
					-- 		stdin = true,
					-- 	}
					-- end,
					require("formatter.filetypes.elixir").mixformat,
				},

				eelixir = {
					util.withl(defaults.prettier, "html"),
				},
				html_eex = {
					util.withl(defaults.prettier, "html"),
				},

				lua = { require("formatter.filetypes.lua").stylua },

				python = {
					-- Configuration for psf/black
					-- function()
					-- 	return {
					-- 		exe = "black", -- this should be available on your $PATH
					-- 		args = { "-" },
					-- 		stdin = true,
					-- 	}
					-- end,
					-- Configuration for ruff
					function()
						return {
							exe = "ruff",
							args = {
								"format",
								"--stdin-filename",
								util.get_current_buffer_file_path(),
							},

							stdin = true,
						}
					end,
				},
				typescriptreact = {
					-- prettier_d_slim,
					-- local_prettier,
					-- prettier_d_slim,
					-- require("formatter.filetypes.javascript").prettierd,
					-- require("formatter.filetypes.javascript").prettier,
					-- local_prettier_d_slim,
					-- require("formatter.filetypes.javascript").prettier,
					-- rome,
					local_prettier,
				},
				typescript = {
					-- local_prettier_d_slim,
					local_prettier,
					-- require("formatter.filetypes.javascript").prettier,
					-- prettier_d_slim,
				},
				html = {
					-- require("formatter.filetypes.html").prettierd
					-- local_prettier_d_slim,
					require("formatter.filetypes.javascript").prettier,
					-- local_prettier,
				},
				css = {
					require("formatter.filetypes.javascript").prettier,
					-- local_prettier,
				},
				javascript = {
					local_prettier,
					-- rome
					-- require("formatter.filetypes.javascript").prettierd,
					require("formatter.filetypes.javascript").prettier,
				},
				javascriptreact = {
					-- rome
					-- require("formatter.filetypes.javascript").prettierd,
					require("formatter.filetypes.javascript").prettier,
				},
				json = {
					-- rome
					-- require("formatter.filetypes.javascript").prettierd,
					require("formatter.filetypes.javascript").prettier,
				},
				markdown = {
					-- local_prettier_d_slim,
					require("formatter.filetypes.html").prettier,
					-- prettier_d_slim,
					-- require("formatter.filetypes.html").prettierd
					-- prettier_d_slim,
					-- local_prettier,
				},
				rust = { require("formatter.filetypes.rust").rustfmt },
				nginx = { nginxfmt },
				-- yaml = { google_yamlfmt }
			},
		})

		vim.keymap.set("n", "<leader>aa", ":Format<cr>", { silent = true })
	end,
}
