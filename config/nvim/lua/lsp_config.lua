local lsp_status = require("lsp-status")
local status = require("rockerboo.lsp_status")
local nvim_lsp = require("lspconfig")

local attach_formatting = function(client)
  -- Skip formatting for these servers. Using prettier for these
  if client.name == "tsserver" then return end
  if client.name == "cssls" then return end

  -- print(string.format("attaching format to %s", client.name))

  -- vim.api.nvim_command [[augroup LSPFormat]]
  -- vim.api.nvim_command [[autocmd! * <buffer>]]
  -- vim.api.nvim_command [[autocmd BufWritePre <buffer> :lua require'rockerboo.utils'.lsp_format()]]
  -- vim.api.nvim_command [[augroup END]]
end

local setup = function()
  status.activate()

  --- Language servers
  local on_attach_vim = function(client)
    print("'" .. client.name .. "' language server attached")

    lsp_status.register_client(client.name)
    require"completion".on_attach(client)
    lsp_status.on_attach(client)

    vim.cmd [[ setlocal omnifunc=v:lua.vim.lsp.omnifunc ]]
    vim.api.nvim_buf_set_keymap(0, "n", "<Leader>aa",
                                "<cmd>lua require'rockerboo.utils'.lsp_format()<cr>", {})

    if client.resolved_capabilities.document_formatting then
      print(string.format("Formatting supported %s", client.name))

    end
  end

  local default_lsp_config = {on_attach = on_attach_vim, capabilities = lsp_status.capabilities}

  local servers = {"elixirls", "rust_analyzer", "tsserver", "gopls", "cssls", "vimls", "bashls"}

  for _, server in ipairs(servers) do nvim_lsp[server].setup(default_lsp_config) end

  -- vim.lsp.handlers["textDocument/formatting"] = function(err, _, result, _, bufnr)
  --   if err ~= nil or result == nil then return end
  --   if not vim.api.nvim_buf_get_option(bufnr, "modified") then
  --     local view = vim.fn.winsaveview()
  --     vim.lsp.util.apply_text_edits(result, bufnr)
  --     vim.fn.winrestview(view)
  --     if bufnr == vim.api.nvim_get_current_buf() then vim.api.nvim_command("noautocmd :update") end
  --   end
  -- end

  require"lspconfig".efm.setup {
    on_attach = on_attach_vim,
    init_options = {documentFormatting = true},
    settings = {
      -- Require formatter configuration files to load
      rootMarkers = {
        ".lua-format",
        ".eslintrc.cjs",
        ".eslintrc",
        ".eslintrc.json",
        ".eslintrc.js",
        ".prettierrc",
        ".prettierrc.js",
        ".prettierrc.json",
        ".prettierrc.yml",
        ".prettierrc.yaml",
        ".prettier.config.js",
        ".prettier.config.cjs",
      },
      -- languages = {lua = {{formatCommand = "lua-format -i", formatStdin = true}}},
    },
    filetypes = {"lua", "typescript", "typescriptreact", "javascript", "html", "json"},
  }

  require("nlua.lsp.nvim").setup(nvim_lsp, {
    on_attach = on_attach_vim,
    capabilities = lsp_status.capabilities,
  })

  -- nvim_lsp.diagnosticls.setup {
  --   on_attach = on_attach_vim,
  --   filetypes = {
  --     "javascript",
  --     "javascriptreact",
  --     "typescript",
  --     "typescriptreact",
  --     "typescript.tsx",
  --     "css",
  --     "markdown",
  --     -- "pandoc",
  --   },
  --   init_options = {
  --     linters = {
  --       eslint = {
  --         command = "yarn eslint",
  --         rootPatterns = {".eslintrc.cjs", ".eslintrc", ".eslintrc.json", ".eslintrc.js", ".git"},
  --         debounce = 100,
  --         args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
  --         sourceName = "eslint",
  --         parseJson = {
  --           errorsRoot = "[0].messages",
  --           line = "line",
  --           column = "column",
  --           endLine = "endLine",
  --           endColumn = "endColumn",
  --           message = "[eslint] ${message} [${ruleId}]",
  --           security = "severity",
  --         },
  --         securities = {[2] = "error", [1] = "warning"},
  --       },
  --       markdownlint = {
  --         command = "yarn markdownlint",
  --         rootPatterns = {".git"},
  --         isStderr = true,
  --         debounce = 100,
  --         args = {"--stdin"},
  --         offsetLine = 0,
  --         offsetColumn = 0,
  --         sourceName = "markdownlint",
  --         securities = {undefined = "hint"},
  --         formatLines = 1,
  --         formatPattern = {"^.*:(\\d+)\\s+(.*)$", {line = 1, column = -1, message = 2}},
  --       },
  --     },
  --     filetypes = {
  --       javascript = "eslint",
  --       javascriptreact = "eslint",
  --       typescript = "eslint",
  --       typescriptreact = "eslint",
  --       ["typescript.tsx"] = "eslint",
  --       markdown = "markdownlint",
  --       -- pandoc = "markdownlint",
  --     },
  --     formatters = {
  --       prettierEslint = {
  --         command = "yarn prettier-eslint",
  --         args = {"--stdin"},
  --         rootPatterns = {
  --           ".eslintrc.cjs",
  --           ".eslintrc",
  --           ".eslintrc.json",
  --           ".eslintrc.js",
  --           ".prettierrc",
  --           ".prettierrc.js",
  --           ".prettierrc.json",
  --           ".prettierrc.yml",
  --           ".prettierrc.yaml",
  --           ".prettier.config.js",
  --           ".prettier.config.cjs",
  --           ".git",
  --         },
  --       },
  --       prettier = {
  --         command = "yarn prettier",
  --         args = {"--stdin-filepath", "%filename"},
  --         rootPatterns = {
  --           ".prettierrc",
  --           ".prettierrc.js",
  --           ".prettierrc.json",
  --           ".prettierrc.yml",
  --           ".prettierrc.yaml",
  --           ".prettier.config.js",
  --           ".prettier.config.cjs",
  --           ".git",
  --         },
  --       },
  --     },
  --     formatFiletypes = {
  --       css = "prettierEslint",
  --       javascript = "prettierEslint",
  --       javascriptreact = "prettierEslint",
  --       json = "prettier",
  --       scss = "prettier",
  --       typescript = "prettierEslint",
  --       typescriptreact = "prettierEslint",
  --       ["typescript.tsx"] = "prettierEslint",
  --     },
  --   },
  -- }
  -- end
end

return {setup = setup}
