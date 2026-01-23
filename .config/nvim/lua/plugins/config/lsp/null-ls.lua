-- none-ls is the community-maintained fork of the archived null-ls
local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/nvimtools/none-ls.nvim
local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions

-- Create autocmd group for format on save
local augroup = vim.api.nvim_create_augroup("LspFormatting", { clear = true })

null_ls.setup({
	sources = {
		formatting.prettierd,
		formatting.stylua,
		formatting.stylelint.with({
			filetypes = { "typescript", "typescriptreact", "javascriptreact" },
		}),
		code_actions.gomodifytags,
	},
	-- format on save with timeout
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.format({
						timeout_ms = 2000,
						bufnr = bufnr,
					})
				end,
			})
		end
	end,
})
