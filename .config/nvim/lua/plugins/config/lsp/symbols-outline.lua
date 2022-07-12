vim.g.symbols_outline = {
	width = 20,
}

vim.api.nvim_set_keymap("n", "<space><space>", ":SymbolsOutline<CR>", { noremap = true, silent = true })
