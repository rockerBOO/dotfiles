local lsp = require("rockerboo.lsp")
local capabilities = require("cmp_nvim_lsp").default_capabilities()
local rt = require("rust-tools")

require("rust-tools").setup({
	tools = {
		hover_actions = { border = false, auto_focus = true },
		cache = true,
		inlay_hints = { auto = false },
	},
	server = {
		on_attach = function(client, bufnr)
			-- Hover actions
			vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
			-- Code action groups
			vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })

			if require("rust-tools.cached_commands").execute_last_runnable then
				vim.keymap.set(
					"n",
					"<Leader>tl",
					require("rust-tools.cached_commands").execute_last_runnable,
					{ buffer = bufnr }
				)
			end

			if require("rust-tools.cached_commands").execute_last_debuggable then
				vim.keymap.set(
					"n",
					"<Leader>dl",
					require("rust-tools.cached_commands").execute_last_debuggable,

					{ buffer = bufnr }
				)
			end

			vim.keymap.set("n", "<Leader>dd", require("rust-tools.debuggables").debuggables, { buffer = bufnr })

			vim.keymap.set("n", "<Leader>tt", require("rust-tools.runnables").runnables, { buffer = bufnr })

			lsp.on_attach_buffer(client, bufnr)
		end,
		capabilities = capabilities,
		cmd = {
			"rustup",
			"run",
			"nightly",
			"rust-analyzer",
		},
		settings = {
			["rust-analyzer"] = {
				checkOnSave = {
					command = "clippy",
				},
				diagnostics = {
					experimental = true,
				},
			},
		},
	},
})
