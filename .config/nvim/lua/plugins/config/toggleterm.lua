local status_ok, toggleterm = pcall(require, "toggleterm")
if not status_ok then
	return
end
toggleterm.setup({
	shade_terminals = false,
	persist_mode = true,
	open_mapping = [[<C-t>]],
	start_in_insert = false,
	update_focused_file = {
		enable = true,
		update_root = true,
		ignore_list = { "toggleterm" },
	},
	winbar = {
		enabled = true,
	},
})

vim.api.nvim_set_keymap("n", "<C-a>", ":ToggleTermToggleAll<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("i", "<C-a>", "<C-\\><C-N> :ToggleTermToggleAll<cr>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("t", "<C-a>", "<C-\\><C-N> :ToggleTermToggleAll<cr>", { silent = true, noremap = true })
