-- local lsp_status = require("lsp-status")
-- lsp_status.register_progress()
-- lsp_status.config {kind_labels = vim.g.completion_customize_lsp_label}
-- local status = require("rockerboo.lsp_status")
local nvim_lsp = require("nvim_lsp")

-- config.capabilities = vim.tbl_extend('keep', default_lsp_config.capabilities or {}, lsp_status.capabilities)
-- not sure what config is to extend this in lsp-status

--- Language servers
local on_attach_vim = function(client)
  print("'" .. client.name .. "' language server started" );
  require"completion".on_attach(client)
  -- require"diagnostic".on_attach(client)
  -- status.on_attach(client)
end

local default_lsp_config = {on_attach = on_attach_vim}

nvim_lsp.elixirls.setup(default_lsp_config)
nvim_lsp.rust_analyzer.setup(default_lsp_config)
-- nvim_lsp.rome.setup(default_lsp_config)
nvim_lsp.tsserver.setup(default_lsp_config)
nvim_lsp.pyls.setup(default_lsp_config)
nvim_lsp.gopls.setup(default_lsp_config)
nvim_lsp.cssls.setup(default_lsp_config)
nvim_lsp.vimls.setup(default_lsp_config)
nvim_lsp.bashls.setup(default_lsp_config)

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
    -- "markdown",
    -- "pandoc",
  },
  init_options = {
    linters = {
      eslint = {
        command = "yarn eslint",
        rootPatterns = {".git"},
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
      -- markdownlint = {
      --   command = "markdownlint",
      --   rootPatterns = {".git"},
      --   isStderr = true,
      --   debounce = 100,
      --   args = {"--stdin"},
      --   offsetLine = 0,
      --   offsetColumn = 0,
      --   sourceName = "markdownlint",
      --   securities = {undefined = "hint"},
      --   formatLines = 1,
      --   formatPattern = {"^.*:(\\d+)\\s+(.*)$", {line = 1, column = -1, message = 2}},
      -- },
    },
    filetypes = {
      javascript = "eslint",
      javascriptreact = "eslint",
      typescript = "eslint",
      typescriptreact = "eslint",
      -- markdown = "markdownlint",
      -- pandoc = "markdownlint",
    },
    formatters = {
      prettierEslint = {command = "yarn prettier-eslint", args = {"--stdin"}, rootPatterns = {".git"}},
      prettier = {command = "yarn prettier", args = {"--stdin-filepath", "%filename"}},
    },
    formatFiletypes = {
      css = "prettier",
      javascript = "prettierEslint",
      javascriptreact = "prettierEslint",
      json = "prettier",
      scss = "prettier",
      typescript = "prettierEslint",
      typescriptreact = "prettierEslint",
      typescripttsx = "prettierEslint"
    },
  },

}

-- nlua.lsp uses sumneko_lua
-- nvim_lsp.sumneko_lua.setup(default_lsp_config)
-- neovim lua lsp
require("nlua.lsp.nvim").setup(nvim_lsp, {on_attach = on_attach_vim})
