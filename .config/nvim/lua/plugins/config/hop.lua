require("hop").setup()
vim.api.nvim_set_keymap("n", "<space><space>", ":HopChar1MW<cr>", { silent = true })
vim.api.nvim_set_keymap("v", "<space><space>", "<cmd>HopChar1MW<CR>", { noremap = true, silent = true })
