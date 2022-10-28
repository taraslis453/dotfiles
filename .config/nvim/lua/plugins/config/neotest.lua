local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
	return
end

neotest.setup({
	adapters = {
		require("neotest-go"),
	},
})

local function map(mode, lhs, rhs, opts)
	local options = { noremap = true, silent = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

map("n", "<space>to", ":lua require('neotest').output.open({ enter = true })<CR>")
map("n", "<space>tr", ":lua require('neotest').run.run(vim.fn.expand('%'))<CR>")
map("n", "<space>dtd", ":lua require('neotest').run.run({ vim.fn.expand('%'), strategy = 'dap' })<CR>")
map("n", "<space>tl", ":lua require('neotest').run.run_last()<CR>")
