-- Install required parsers using the new nvim-treesitter API
local parsers_to_install = {
  "go",
  "lua",
  "sql",
  "markdown",
  "markdown_inline",
  "vim",
  "vimdoc",
}

-- Install parsers asynchronously
vim.defer_fn(function()
  local ok, treesitter = pcall(require, "nvim-treesitter")
  if ok then
    -- Install parsers with a timeout
    pcall(function()
      treesitter.install(parsers_to_install):wait(300000) -- 5 minute timeout
    end)
  end
end, 0)

-- Set up treesitter-based folding for supported filetypes
vim.api.nvim_create_autocmd("FileType", {
  pattern = { "go", "lua", "sql", "markdown" },
  callback = function()
    vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
    vim.wo.foldmethod = "expr"
    vim.wo.foldenable = false -- Don't fold by default, but enable the fold method
  end,
})
