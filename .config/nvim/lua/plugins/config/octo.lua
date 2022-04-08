local status_ok, octo = pcall(require, "octo")
if not status_ok then
	return
end

octo.setup()
local opts = { noremap = true, silent = true }

vim.api.nvim_set_keymap("n", "<space>pl", ":Octo pr list<CR>", opts)
