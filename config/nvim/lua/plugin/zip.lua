-- WIP
-- zip to handle yarn packages and be able unzip them for handling finding source files
-- neovim/vim has a zipPlugin.vim which mostly works by executing commands on the OS (zip)
-- would this be faster or better by reworking zip into lua instead of using the vimscript version?

local decode_uri = function(uri)
	-- vim.fn.substitute(
	-- 	uri,
	-- 	"%([a-fA-F0-9][a-fA-F0-9])",
	-- 	'=nr2char("0x", submatch(1))',
	-- 	"g"
	-- )

	return uri:gsub("%([a-fA-F0-9][a-fA-F0-9])", '=nr2char("0x", submatch(1))')
end

local clear_duplicate_buffers = function(uri)
	local decoded = decode_uri(uri)
	if decoded ~= uri then
		local escaped = vim.fn.fnameescape(decoded)
		vim.cmd(string.format([[ sil! exe "bwipeout " . %s ]], escaped))
		vim.cmd(string.format([[ exe "keepalt file " . %s ]], escaped))
		vim.cmd(string.format([[ sil! exe "bwipeout  " . %s ]], vim.fn.fnameescape(uri)))
	end
end

local rzip_override = function()
	-- local autocmd = vim.api.nvim_create_autocmd
	-- local clear_autocmds = vim.api.nvim_clear_autocmds
	-- local delete_autocmd = vim.api.nvim_del_autocmd

	-- clear_autocmds({'zip'}
end

return {
	decode_uri = decode_uri,
	clear_duplicate_buffers = clear_duplicate_buffers,
	rzip_override = rzip_override,
}
