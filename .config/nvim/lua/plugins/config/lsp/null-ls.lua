local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions
null_ls.setup({
	sources = {
		formatting.prettierd,
		formatting.stylua,
		formatting.goimports,
		formatting.gofmt,
		formatting.stylelint.with({
			filetypes = { "typescript", "typescriptreact", "javascriptreact" },
		}),
		code_actions.gomodifytags,
	},
	-- format on save
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = "bufcheck",
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format()
				end,
			})
		end
	end,
})
