local opts = { noremap = true, silent = true }

-- Shorten function name
local keymap = vim.api.nvim_set_keymap

--Remap , as leader key
keymap("", ",", "<Nop>", opts)
vim.g.mapleader = ","
vim.g.maplocalleader = ","

-- Normal --
-- Better window navigation
keymap("n", "<C-h>", "<C-w>h", opts)
keymap("n", "<C-j>", "<C-w>j", opts)
keymap("n", "<C-k>", "<C-w>k", opts)
keymap("n", "<C-l>", "<C-w>l", opts)
keymap("i", "<C-h>", "<C-\\><C-N><C-w>h", opts)
keymap("i", "<C-j>", "<C-\\><C-N><C-w>j", opts)
keymap("i", "<C-k>", "<C-\\><C-N><C-w>k", opts)
keymap("i", "<C-l>", "<C-\\><C-N><C-w>l", opts)
keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", opts)
keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", opts)
keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", opts)
keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", opts)

keymap("n", "Y", "yg$", opts)

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -6<CR>", opts)
keymap("n", "<C-Down>", ":resize +6<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize -6<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize +6<CR>", opts)
keymap("i", "<C-Up>", "<C-\\><C-N> :resize -6<CR>", opts)
keymap("i", "<C-Down>", "<C-\\><C-N> :resize +6<CR>", opts)
keymap("i", "<C-Right>", "<C-\\><C-N> :vertical resize -6<CR>", opts)
keymap("i", "<C-Left>", "<C-\\><C-N> :vertical resize +6<CR>", opts)
keymap("t", "<C-Up>", "<C-\\><C-N> :resize -6<CR>", opts)
keymap("t", "<C-Down>", "<C-\\><C-N> :resize +6<CR>", opts)
keymap("t", "<C-Right>", "<C-\\><C-N> :vertical resize -6<CR>", opts)
keymap("t", "<C-Left>", "<C-\\><C-N> :vertical resize +6<CR>", opts)

keymap("n", "<C-w>t", ":tab split<CR>", opts)
keymap("n", "<C-w>s", ":vsplit<CR>", opts)
keymap("n", "<C-w>i", ":split<CR>", opts)

-- insert blank line on enter
keymap("n", "<CR>", "o<Esc>", opts)
keymap("n", "<S-CR>", "O<Esc>", opts)

-- move lines
keymap("v", "J", ":m '>+1<CR>gv=gv", opts)
keymap("v", "K", ":m '<-2<CR>gv=gv", opts)

vim.cmd([[nnoremap  \ :noh<return>]])
-- Don't yank on visual paste
keymap("v", "p", '"_dP', opts)
keymap("n", "]q", ":cn<CR>", opts)
keymap("n", "[q", ":cp<CR>", opts)

-- remove /n on copy in terminal with C-v
-- used for copying to clipboard in terminal
vim.cmd([[
  vmap <C-C> "+y:let @+ = substitute(@+, "\n\n\n*", "±", "g")
  \\|:let @+ = substitute(@+, "\n", "", "g")<CR>
   \\|:let @+ = substitute(@+, "±", "\\n", "g")<CR>
   \\|'<
]])

keymap("n", "<space>q", ":q<CR>", opts)
keymap("n", "<space>Q", ":qa<CR>", opts)
keymap("n", "<space>w", ":w<CR>", opts)
keymap("n", "<space>W", ":wa<CR>", opts)
keymap("n", "<space>z", ":wq<CR>", opts)

keymap("n", "<space>f", ":Format<CR>", opts)

-- exit terminal mode
vim.cmd([[tnoremap <A-\> <C-\><C-n>]])

-- Disable accidentally pressing ctrl-z and suspending
keymap("n", "<C-z>", "<Nop>", opts)
-- Yank without cursor movement
keymap("v", "y", "y`]", opts)
