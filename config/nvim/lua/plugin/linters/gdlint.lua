-- ./Glow.gd:10: Error: unused function argument 'delta' (unused-argument)
-- ./mob.gd:5: Error: Trailing whitespace(s) (trailing-whitespace)
local pattern = [[%s*(%d+):(%d+)%s+(%w+)%s+(.+%S)%s+(%S+)]]
local groups = { "lnum", "col", "severity", "message", "code" }
local severity_map = {
	["Error"] = vim.diagnostic.severity.ERROR,
	-- ["warn"] = vim.diagnostic.severity.WARN,
	-- ["warning"] = vim.diagnostic.severity.WARN,
}

-- require("lint").linters.gdlint = {
-- 	cmd = "gdlint",
-- 	stdin = false,
-- 	parser = require("lint.parser").from_pattern(
-- 		pattern,
-- 		groups,
-- 		severity_map,
-- 		{ ["source"] = "gdlint" }
-- 	),
-- }
