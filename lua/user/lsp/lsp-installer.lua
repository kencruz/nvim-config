local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local servers = {
  --[[ "sumneko_lua", ]]
  "lua_ls",
  "cssls",
  "html",
  -- "tsserver",
  "pyright",
  "bashls",
  "jsonls",
  "yamlls",
  -- "rust_analyzer",
  "clangd",
  "eslint",
}

mason.setup()

local mason_lspconfig_status_ok, mason_lspconfig = pcall(require, "mason-lspconfig")
if not mason_lspconfig_status_ok then
  return
end

mason_lspconfig.setup()

local lspconfig_status_ok, lspconfig = pcall(require, "lspconfig")
if not lspconfig_status_ok then
  return
end

-- lspconfig.eslint.setup({
--   flags = {
--     allow_incremental_sync = false,
--     debounce_text_changes = 1000,
--   },
-- })

-- lspconfig.eslint.setup {
--   cmd = { "vscode-eslint-language-server", "--stdio" },
-- }

local opts = {}

for _, server in pairs(servers) do
  opts = {
    on_attach = require("user.lsp.handlers").on_attach,
    capabilities = require("user.lsp.handlers").capabilities,
  }

  --[[ if server == "lua_ls" then ]]
  --[[   local sumneko_opts = require "user.lsp.settings.sumneko_lua" ]]
  --[[   opts = vim.tbl_deep_extend("force", sumneko_opts, opts) ]]
  --[[ end ]]

  if server == "pyright" then
    local pyright_opts = require "user.lsp.settings.pyright"
    opts = vim.tbl_deep_extend("force", pyright_opts, opts)
  end

  if server == "eslint" then
    -- opts['settings.flags'] = {
    --   allow_incremental_sync = true,
    --   debounce_text_changes = 1000,
    -- }

    local eslint_opts = {
      flags = {
        allow_incremental_sync = false,
        debounce_text_changes = 2000,
      },
      settings = {
        flags = {
          allow_incremental_sync = false,
          debounce_text_changes = 2000,
        },
        codeAction = {
          disableRuleComment = {
            enable = true,
            location = "separateLine"
          },
          showDocumentation = {
            enable = true
          }
        },
        codeActionOnSave = {
          enable = false,
          mode = "all"
        },
        experimental = {
          useFlatConfig = false
        },
        format = true,
        nodePath = "",
        onIgnoredFiles = "off",
        problems = {
          shortenToSingleLine = false
        },
        quiet = false,
        rulesCustomizations = {},
        run = "onSave",
        useESLintClass = false,
        validate = "on",
        workingDirectory = {
          mode = "location"
        }
      }
    }

    opts = vim.tbl_deep_extend("force", eslint_opts, opts)
    -- opts['settings']['run'] = 'onSave'
    -- opts.cmd = { "eslint_d", "--stdin", "--stdin-filename"}
    -- opts.cmd = { "/nix/store/y0hdl91a6ds51n8jajh50pljicrx5yca-eslint_d-14.3.0/bin/eslint_d", "--stdio"}
  end

  lspconfig[server].setup(opts)
end
