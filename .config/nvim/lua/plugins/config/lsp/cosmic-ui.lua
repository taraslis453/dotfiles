require("cosmic-ui").setup()
vim.api.nvim_set_keymap(
	"v",
	"ga",
	'<cmd>lua require("cosmic-ui").range_code_actions()<cr>',
	{ noremap = true, silent = true }
)
vim.api.nvim_set_keymap("n", "R", '<cmd>lua require("cosmic-ui").rename()<cr>', { noremap = true, silent = true })
