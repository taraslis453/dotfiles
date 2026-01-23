local status_ok, mason = pcall(require, "mason")
if not status_ok then
  return
end

local status_ok_1, mason_lspconfig = pcall(require, "mason-lspconfig")
if not status_ok_1 then
  return
end

local servers = {
  "gopls",
  "golangci_lint_ls",
  "lua_ls",
}

local settings = {
  ui = {
    border = "rounded",
    icons = { package_installed = "◍", package_pending = "◍", package_uninstalled = "◍" },
  },
  log_level = vim.log.levels.INFO,
  max_concurrent_installers = 4,
}

mason.setup(settings)
mason_lspconfig.setup({ ensure_installed = servers, automatic_installation = true })

-- Get handlers module
local handlers = require("plugins.config.lsp.handlers")

-- Setup each server using the new vim.lsp.config API
for _, server in pairs(servers) do
  local server_name = vim.split(server, "@")[1]
  
  local opts = {
    on_init = handlers.on_init,
    on_attach = handlers.on_attach,
    capabilities = handlers.capabilities,
  }

  -- Apply server-specific settings
  if server_name == "jsonls" then
    local jsonls_opts = require("plugins.config.lsp.settings.jsonls")
    opts = vim.tbl_deep_extend("force", jsonls_opts, opts)
  end

  if server_name == "lua_ls" then
    local lua_ls_opts = require("plugins.config.lsp.settings.lua_ls")
    opts = vim.tbl_deep_extend("force", lua_ls_opts, opts)
  end

  if server_name == "gopls" then
    local gopls_opts = require("plugins.config.lsp.settings.gopls")
    opts = vim.tbl_deep_extend("force", gopls_opts, opts)
  end

  if server_name == "golangci_lint_ls" then
    -- Only enable for projects with .golangci.yml
    opts.root_markers = { ".golangci.yml", ".golangci.yaml" }
  end

  -- Use vim.lsp.config to configure the server
  vim.lsp.config(server_name, opts)
  
  -- Enable the server
  vim.lsp.enable(server_name)
end

-- Note: Copilot LSP is automatically managed by copilot.lua plugin
-- sidekick.nvim will connect to it automatically for NES (Next Edit Suggestions)
