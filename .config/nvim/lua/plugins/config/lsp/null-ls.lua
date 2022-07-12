local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- local diagnostics = null_ls.builtins.diagnostics
null_ls.setup({
	sources = {
		formatting.prettierd,
		formatting.stylua,
		formatting.goimports,
		formatting.gofmt,
		formatting.stylelint.with({
			filetypes = { "typescript", "typescriptreact", "javascriptreact" },
		}),
		-- TODO: find a way to fix error: stylelint: Error: No configuration provided for
		-- diagnostics.stylelint.with({
		-- 	filetypes = { "typescript", "typescriptreact", "javascriptreact" },
		-- }),
	},
	-- format on save
	on_attach = function(client)
		if client.supports_method("textDocument/formatting") then
			vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.format()")
		end
	end,
})
