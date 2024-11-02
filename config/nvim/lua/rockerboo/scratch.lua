local M = {}

M.run_script = function()
	-- vim.cmd(":vsplit term://top")
	-- require("FTerm").run({ "python", "nsfw.py" })
	-- require("FTerm").run({ "python", "lora-inspector.py", "/mnt/900/lora/latentlabs360_v01.safetensors" })
	require("FTerm").run({ "python", "parsers.py" })
end

return M
