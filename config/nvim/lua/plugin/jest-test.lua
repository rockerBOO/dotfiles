local m = {}

m.run_single_test = function()
	local file = vim.fn.expand("%:p")
	local block = ""

	local output = os.execute(string.format('yarn jest --json -i %s -t "%s"', file, block))

	print("got output " .. #output)
end

m.run_single_file = function()
	local file = vim.fn.expand("%:p")

	local output = os.execute("yarn jest --json --useStderr -i " .. file)
	print("got output " .. #output)
end

return m
