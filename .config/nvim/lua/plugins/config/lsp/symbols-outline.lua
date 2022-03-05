vim.g.symbols_outline = {
	width = 70,
}

vim.api.nvim_set_keymap("n", "<leader>s", ":SymbolsOutline<CR>", { noremap = true, silent = true })
