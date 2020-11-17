local lsp_status = require("lsp-status")
local status = require("rockerboo.lsp_status")
local nvim_lsp = require("lspconfig")

function DoFormat()
  vim.lsp.buf.formatting_sync(nil, 1000)
end

local attach_formatting = function(client)
  -- Skip tsserver for now so we dont format things twice
  if client.name == "tsserver" then return end

  print(string.format('attaching format to %s', client.name))

  vim.api.nvim_command [[augroup Format]]
  vim.api.nvim_command [[autocmd! * <buffer>]]
  vim.api.nvim_command [[autocmd BufWritePre <buffer> lua DoFormat()]]
  vim.api.nvim_command [[augroup END]]
end

local setup = function()
  status.activate()

  --- Language servers
  local on_attach_vim = function(client)

    lsp_status.register_client(client.name)

    print("'" .. client.name .. "' language server attached");
    require"completion".on_attach(client)

    require"lsp-status".on_attach(client)

    vim.cmd("setlocal omnifunc=v:lua.vim.lsp.omnifunc")

    if client.resolved_capabilities.document_formatting then
      print(string.format("Formatting supported %s", client.name))

      attach_formatting(client)
    end

    -- If the client is a documentSymbolProvider, set up an autocommand
    -- to update the containing function
    -- not necessary if registered
    -- if client.resolved_capabilities.document_symbol then
    --   print(string.format("Document symbols supported %s", client.name))
    --   print(vim.inspect(lsp_status.messages()))

    --   vim.api.nvim_command("augroup lsp_aucmds")
    --   vim.api.nvim_command(
    --       "au CursorHold <buffer> lua require(\"lsp-status\").update_current_function()")
    --   vim.api.nvim_command("augroup END")
    -- end

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

  --   nvim_lsp["efm"].setup({
  --     on_attach = function(client)
  --       print("wtf?")
  --       on_attach_vim(client)
  --     end,
  --     filetypes = {"lua", "typescript", "javascript"},
  --   })
  -- nvim_lsp.efm.setup {on_attach = on_attach_vim, filetypes = {"lua", "typescript.tsx" }}

  require("nlua.lsp.nvim").setup(nvim_lsp, {
    on_attach = on_attach_vim,
    capabilities = lsp_status.capabilities,
  })

  nvim_lsp.diagnosticls.setup {
    on_attach = on_attach_vim,
    filetypes = {
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "typescript.tsx",
      "css",
      "scss",
      "markdown",
      -- "pandoc",
    },
    init_options = {
      linters = {
        eslint = {
          command = "eslint",
          rootPatterns = {".git", ".eslintrc.cjs", ".eslintrc", ".eslintrc.json", ".eslintrc.js"},
          debounce = 100,
          args = {"--stdin", "--stdin-filename", "%filepath", "--format", "json"},
          sourceName = "eslint",
          parseJson = {
            errorsRoot = "[0].messages",
            line = "line",
            column = "column",
            endLine = "endLine",
            endColumn = "endColumn",
            message = "[eslint] ${message} [${ruleId}]",
            security = "severity",
          },
          securities = {[2] = "error", [1] = "warning"},
        },
        markdownlint = {
          command = "markdownlint",
          rootPatterns = {".git"},
          isStderr = true,
          debounce = 100,
          args = {"--stdin"},
          offsetLine = 0,
          offsetColumn = 0,
          sourceName = "markdownlint",
          securities = {undefined = "hint"},
          formatLines = 1,
          formatPattern = {"^.*:(\\d+)\\s+(.*)$", {line = 1, column = -1, message = 2}},
        },
      },
      filetypes = {
        javascript = "eslint",
        javascriptreact = "eslint",
        typescript = "eslint",
        typescriptreact = "eslint",
        ["typescript.tsx"] = "eslint",
        markdown = "markdownlint",
        -- pandoc = "markdownlint",
      },
      formatters = {
        prettierEslint = {
          command = "prettier-eslint",
          args = {"--stdin"},
          rootPatterns = {".eslintrc.cjs", ".eslintrc", ".eslintrc.json", ".eslintrc.js", ".git"},
        },
        prettier = {command = "prettier", args = {"--stdin-filepath", "%filename"}},
      },
      formatFiletypes = {
        css = "prettier",
        javascript = "prettierEslint",
        javascriptreact = "prettierEslint",
        json = "prettier",
        scss = "prettier",
        typescript = "prettierEslint",
        typescriptreact = "prettierEslint",
        ["typescript.tsx"] = "prettierEslint",
      },
    },
  }
end

return {setup = setup}
