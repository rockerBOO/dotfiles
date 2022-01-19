-- Express Line
local builtin = require("el.builtin")
local extensions = require("el.extensions")
local sections = require("el.sections")
local subscribe = require("el.subscribe")
local lsp_statusline = require("el.plugins.lsp_status")

require("el").reset_windows()

-- generator(win_id)
local generator = function(_)
	return {
		extensions.gen_mode({ format_string = "%s" }),
		sections.split,
		subscribe.buf_autocmd("el_file_icon", "BufRead", function(_, bufnr)
			local icon = extensions.file_icon(_, bufnr)
			if icon then
				return icon .. " "
			end
			return ""
		end),
		builtin.make_responsive_file(140, 90),
		sections.collapse_builtin({ " ", builtin.modified_flag }),
		sections.split,
		lsp_statusline.status,
		lsp_statusline.server_progress,
		builtin.line,
		",",
		builtin.column,
		" ",
		sections.collapse_builtin({ "", builtin.help_list, builtin.readonly_list, "" }),
		function(_, buffer)
			return buffer.filetype
		end,
	}
end

require("el").setup({ generator = generator })
