require("toggleterm").setup({
	shade_terminals = false,
	open_mapping = [[<C-t>]],
	start_in_insert = false,
})

vim.cmd([[tnoremap <A-\> <C-\><C-n>]])

vim.api.nvim_set_keymap("n", "<C-a>", ":ToggleTermToggleAll<cr>", { silent = true })
vim.api.nvim_set_keymap("i", "<C-a>", "<C-\\><C-N> :ToggleTermToggleAll<cr>", { silent = true })
vim.api.nvim_set_keymap("t", "<C-a>", "<C-\\><C-N> :ToggleTermToggleAll<cr>", { silent = true })
