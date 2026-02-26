local status_ok, catppuccin = pcall(require, "catppuccin")
if status_ok then
  catppuccin.setup({
    flavour = "mocha", -- mocha, macchiato, frappe, latte
    transparent_background = false,
    term_colors = true,
    styles = {
      comments = { "italic" },
      conditionals = {},
      loops = {},
      functions = {},
      keywords = {},
      strings = {},
      variables = {},
      numbers = {},
      booleans = {},
      properties = {},
      types = {},
    },
    integrations = {
      cmp = true,
      gitsigns = true,
      nvimtree = true,
      treesitter = true,
      telescope = true,
      which_key = true,
      mason = true,
      hop = true,
      markdown = true,
      native_lsp = {
        enabled = true,
        virtual_text = {
          errors = { "italic" },
          hints = { "italic" },
          warnings = { "italic" },
          information = { "italic" },
        },
        underlines = {
          errors = { "underline" },
          hints = { "underline" },
          warnings = { "underline" },
          information = { "underline" },
        },
      },
    },
    color_overrides = {
      mocha = {
        -- Cursor-like background colors
        base = "#1e1e1e",
        mantle = "#181818",
        crust = "#141414",
      },
    },
    -- Link LSP semantic token groups to treesitter groups
    -- This prevents semantic tokens from overriding treesitter colors
    custom_highlights = function(colors)
      return {
        -- Visible border between windows
        WinSeparator = { fg = colors.blue },
        NormalNC = { bg = colors.mantle },
        -- Link all LSP semantic token types to their treesitter equivalents
        ["@lsp.type.namespace"] = { link = "@namespace" },
        ["@lsp.type.type"] = { link = "@type" },
        ["@lsp.type.class"] = { link = "@type" },
        ["@lsp.type.enum"] = { link = "@type" },
        ["@lsp.type.interface"] = { link = "@type" },
        ["@lsp.type.struct"] = { link = "@structure" },
        ["@lsp.type.parameter"] = { link = "@parameter" },
        ["@lsp.type.variable"] = { link = "@variable" },
        ["@lsp.type.property"] = { link = "@property" },
        ["@lsp.type.enumMember"] = { link = "@constant" },
        ["@lsp.type.function"] = { link = "@function" },
        ["@lsp.type.method"] = { link = "@method" },
        ["@lsp.type.macro"] = { link = "@macro" },
        ["@lsp.type.decorator"] = { link = "@function" },
        ["@lsp.type.comment"] = { link = "@comment" },
      }
    end,
  })
end

vim.cmd("colorscheme catppuccin")
