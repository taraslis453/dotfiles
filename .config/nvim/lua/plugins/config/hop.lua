require("hop").setup()
vim.api.nvim_set_keymap("n", "<space>s", ":HopChar2MW<cr>", { silent = true })
vim.api.nvim_set_keymap("v", "<space>s", "<cmd>HopChar2MW<CR>", { noremap = true, silent = true })
