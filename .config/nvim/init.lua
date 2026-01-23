-- Prevent LSP semantic tokens from overwriting treesitter colors
-- Set this FIRST before any plugins load
-- https://github.com/NvChad/NvChad/issues/1907
-- Treesitter has priority 100, so set semantic tokens lower
if vim.hl and vim.hl.priorities then
  vim.hl.priorities.semantic_tokens = 95
elseif vim.highlight and vim.highlight.priorities then
  vim.highlight.priorities.semantic_tokens = 95
end

-- Disable vim's built-in syntax highlighting to prevent conflicts with treesitter
vim.cmd("syntax off")

-- Enable treesitter highlighting for all filetypes
-- This autocmd is set up BEFORE plugins load to ensure it runs before LSP attaches
-- Official docs: :h treesitter-highlight
vim.api.nvim_create_autocmd("FileType", {
  callback = function(args)
    local buf = args.buf
    local ft = args.match
    
    -- Skip special buffers and filetypes that don't have parsers
    local excluded_fts = {
      "fzf",
      "NvimTree",
      "alpha",
      "dashboard",
      "help",
      "lazy",
      "mason",
      "TelescopePrompt",
      "TelescopeResults",
      "toggleterm",
      "qf",
      "checkhealth",
      "gitcommit",
      "gitrebase",
      "",
    }
    
    if vim.tbl_contains(excluded_fts, ft) then
      return
    end
    
    -- Check if buffer is valid and is a normal file buffer
    if not vim.api.nvim_buf_is_valid(buf) or vim.bo[buf].buftype ~= "" then
      return
    end
    
    -- Try to start treesitter, silently fail if no parser exists
    pcall(vim.treesitter.start, buf)
  end,
})

require("common.options")
require("common.keymaps")
require("common.autocmd")
require("plugins.init")
