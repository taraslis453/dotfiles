local function map(mode, lhs, rhs, opts)
	local options = { noremap = true }
	if opts then
		options = vim.tbl_extend("force", options, opts)
	end
	vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
map("n", "<space>db", ':lua require"dap".toggle_breakpoint()<CR>')
map("n", "<space>dso", ':lua require"dap".step_out()<CR>')
map("n", "<space>dsi", ':lua require"dap".step_into()<CR>')
map("n", "<space>dsv", ':lua require"dap".step_over()<CR>')
map("n", "<space>dc", ':lua require"dap".continue()<CR>')
map("n", "<space>dn", ':lua require"dap".run_to_cursor()<CR>')
map("n", "<space>de", ':lua require"dap".close()<CR>')
map("n", "<space>dk", ':lua require"dap".up()<CR>zz')
map("n", "<space>dj", ':lua require"dap".down()<CR>zz')
map("n", "<space>dt", ':lua require"dap".terminate()<CR>')
map("n", "<space>dr", ':lua require"dap".repl.toggle({}, "vsplit")<CR><C-w>l')
map("n", "<space>dR", ':lua require"dap".clear_breakpoints()<CR>')
map("n", "<space>dh", ':lua require"dap.ui.widgets".hover()<CR>')
map("n", "<space>ds", ':lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>')
map("n", "<space>dac", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>")
map("n", "<space>du", ':lua require"dapui".toggle()<CR>')

local status_ok, dapgo = pcall(require, "dap-go")
if not status_ok then
	return
end
dapgo.setup()

local status_ok, nvimDapVirtualText = pcall(require, "nvim-dap-virtual-text")
if not status_ok then
	return
end
nvimDapVirtualText.setup()

require("dapui").setup({
	icons = { expanded = "▾", collapsed = "▸" },
	mappings = {
		-- Use a table to apply multiple mappings
		expand = { "<CR>", "<2-LeftMouse>" },
		open = "o",
		remove = "d",
		edit = "e",
		repl = "r",
		toggle = "t",
	},
	layouts = {
		{
			-- You can change the order of elements in the sidebar
			elements = {
				-- Provide as ID strings or tables with "id" and "size" keys
				{
					id = "scopes",
					size = 0.25, -- Can be float or integer > 1
				},
				{ id = "breakpoints", size = 0.25 },
				{ id = "stacks", size = 0.25 },
				{ id = "watches", size = 00.25 },
			},
			size = 40,
			position = "left", -- Can be "left", "right", "top", "bottom"
		},
		{
			elements = { "repl" },
			size = 10,
			position = "bottom", -- Can be "left", "right", "top", "bottom"
		},
	},
	floating = {
		max_height = nil, -- These can be integers or a float between 0 and 1.
		max_width = nil, -- Floats will be treated as percentage of your screen.
		border = "single", -- Border style. Can be "single", "double" or "rounded"
		mappings = {
			close = { "q", "<Esc>" },
		},
	},
	render = { indent = 1 },
})

-- uncomment to open dapui on start
--[[ local dap, dapui = require("dap"), require("dapui") ]]
--[[ dap.listeners.after.event_initialized["dapui_config"] = function() ]]
--[[ 	dapui.open() ]]
--[[ end ]]
--[[ dap.listeners.before.event_terminated["dapui_config"] = function() ]]
--[[ 	dapui.close() ]]
--[[ end ]]
--[[ dap.listeners.before.before_exited["dapui_config"] = function() ]]
--[[ 	dapui.close() ]]
--[[ end ]]
vim.api.nvim_set_hl(0, "DapBreakpoint", { ctermbg = 0, fg = "#993939" })
vim.api.nvim_set_hl(0, "DapBreakpointRejected", { ctermbg = 0, fg = "#61afef" })
vim.api.nvim_set_hl(0, "DapStopped", { ctermbg = 0, fg = "#98c379" })

vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "DapBreakpoint" })
vim.fn.sign_define(
	"DapBreakpointRejected",
	{ text = "🟦", texthl = "", linehl = "", numhl = "DapBreakpointRejected" }
)
vim.fn.sign_define("DapStopped", { text = "🟩", texthl = "", linehl = "", numhl = "DapStopped" })
