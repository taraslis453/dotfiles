-- Setup LSP handlers first
require("plugins.config.lsp.handlers").setup()

-- Setup mason and LSP servers
require("plugins.config.lsp.mason")

-- Setup additional LSP tools
require("plugins.config.lsp.trouble")
