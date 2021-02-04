local lsp_status = require("lsp-status")
local status = require("rockerboo.lsp_status")
local nvim_lsp = require("lspconfig")

local setup = function()
  status.activate()

  --- Language servers
  local on_attach_vim = function(client)
    print("'" .. client.name .. "' language server attached")

    require"completion".on_attach(client)
    lsp_status.on_attach(client)

    vim.cmd [[ setlocal omnifunc=v:lua.vim.lsp.omnifunc ]]

    if client.resolved_capabilities.document_formatting then

      vim.api.nvim_buf_set_keymap(0, "n", "<Leader>aa",
                                  "<cmd>lua require'rockerboo.utils'.lsp_format()<cr>", {})
      print(string.format("Formatting supported %s", client.name))

    end
  end

  local default_lsp_config = {on_attach = on_attach_vim, capabilities = lsp_status.capabilities}

  local servers = {"rust_analyzer", "tsserver", "gopls", "cssls", "vimls", "bashls"}

  for _, server in ipairs(servers) do nvim_lsp[server].setup(default_lsp_config) end

  require'lspconfig'.elixirls.setup { cmd = {"elixir-ls"}, on_attach = on_attach_vim }
  
  require"lspconfig".efm.setup {
    on_attach = on_attach_vim,
    init_options = {documentFormatting = true},
    settings = {
      -- Require formatter configuration files to load
      rootMarkers = {
        ".lua-format",
        -- ".eslintrc.cjs",
        -- ".eslintrc",
        -- ".eslintrc.json",
        -- ".eslintrc.js",
        ".prettierrc",
        ".prettierrc.js",
        ".prettierrc.json",
        ".prettierrc.yml",
        ".prettierrc.yaml",
        ".prettier.config.js",
        ".prettier.config.cjs",
      },
    },
  }

  require("nlua.lsp.nvim").setup(nvim_lsp, {
    cmd = {"lua-language-server", "-E", "/home/rockerboo/build/lua-language-server/main.lua"},
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
  --   },
  -- }
end

return {setup = setup}
