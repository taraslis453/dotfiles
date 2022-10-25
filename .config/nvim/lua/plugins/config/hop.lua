local status_ok, hop = pcall(require, "hop")
if not status_ok then
	return
end
hop.setup()
vim.api.nvim_set_keymap("n", "<space>s", ":HopChar2MW<cr>", { silent = true })
vim.api.nvim_set_keymap("v", "<space>s", "<cmd>HopChar2MW<CR>", { noremap = true, silent = true })
