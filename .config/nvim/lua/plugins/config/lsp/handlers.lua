local M = {}

M.setup = function()
  local config = {
    virtual_text = true,
    -- show signs
    signs = {
      text = {
        [vim.diagnostic.severity.ERROR] = "",
        [vim.diagnostic.severity.WARN] = "",
        [vim.diagnostic.severity.HINT] = "",
        [vim.diagnostic.severity.INFO] = "",
      },
    },
    update_in_insert = false,
    underline = true,
    severity_sort = true,
    float = {
      focusable = true,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = "",
    },
  }

  vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
    border = "rounded",
    -- Enable syntax highlighting in hover window
    stylize_markdown = true,
    -- Focus the hover window to enable scrolling
    focusable = true,
    -- Set max width/height for better readability
    max_width = 80,
    max_height = 30,
  })

  vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
    border = "rounded",
  })

  vim.diagnostic.config(config)
  
  -- Disable default global LSP keymaps that conflict with custom mappings
  -- grr conflicts with custom gr mapping in fzf.lua
  pcall(vim.keymap.del, 'n', 'grr')
  pcall(vim.keymap.del, 'n', 'grn')
  pcall(vim.keymap.del, 'n', 'gra')
  pcall(vim.keymap.del, 'v', 'gra')
  pcall(vim.keymap.del, 'n', 'gri')
  pcall(vim.keymap.del, 'n', 'grt')
  
  -- Enable treesitter highlighting in LSP hover windows
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
      vim.treesitter.start()
    end,
  })
end

M.on_init = function(client, _)
  -- Disable semantic tokens to prevent them from overriding treesitter highlighting
  -- Combined with vim.hl.priorities.semantic_tokens = 95 in init.lua, this ensures
  -- treesitter highlighting always takes precedence
  if client.server_capabilities.semanticTokensProvider then
    client.server_capabilities.semanticTokensProvider = nil
  end
end

local function lsp_keymaps(bufnr)
  local opts = { buffer = bufnr }
  vim.keymap.set("n", "gD", vim.lsp.buf.declaration, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))
  vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
  vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover documentation" }))
  vim.keymap.set("n", "gi", vim.lsp.buf.implementation, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))
  vim.keymap.set("n", "gs", vim.lsp.buf.signature_help, vim.tbl_extend("force", opts, { desc = "Signature help" }))
  vim.keymap.set("n", "gl", vim.diagnostic.open_float, vim.tbl_extend("force", opts, { desc = "Open diagnostic float" }))
  vim.keymap.set("n", "[g", function()
    vim.diagnostic.goto_prev({ border = "rounded" })
  end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
  vim.keymap.set("n", "]g", function()
    vim.diagnostic.goto_next({ border = "rounded" })
  end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
  vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, vim.tbl_extend("force", opts, { desc = "Diagnostic loclist" }))
  vim.keymap.set("n", "ga", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
  vim.keymap.set("v", "ga", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action (range)" }))
  vim.keymap.set("n", "R", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
  
  -- Toggle inlay hints (Neovim 0.10+)
  if vim.lsp.inlay_hint then
    vim.keymap.set("n", "<leader>h", function()
      vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
    end, vim.tbl_extend("force", opts, { desc = "Toggle inlay hints" }))
  end

  vim.cmd([[ command! Format execute 'lua vim.lsp.buf.format({async = true})' ]])
end

local navic = require("nvim-navic")

M.on_attach = function(client, bufnr)
  if client.name == "lua_ls" then
    client.server_capabilities.documentFormattingProvider = false
  end
  if client.name == "stylelint_lsp" then
    client.server_capabilities.documentFormattingProvider = false
  end
  -- gopls formatting enabled (gofumpt + organize imports)

  -- format on save
  if client:supports_method("textDocument/formatting") then
    vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
  end
  if client:supports_method("textDocument/documentSymbol") then
    navic.attach(client, bufnr)
  end

  lsp_keymaps(bufnr)
  
  -- Inlay hints are disabled by default, use <leader>h to toggle them on/off
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.default_capabilities(capabilities)

return M
