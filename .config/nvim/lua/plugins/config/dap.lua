local dap = require("dap")
local base_path = os.getenv("HOME") .. "/daps"
-- require("dap-go").setup()
dap.adapters.go = {
	type = "executable",
	command = "node",
	args = { base_path .. "/vscode-go/dist/debugAdapter.js" },
}
dap.configurations.go = {
	{
		type = "go",
		name = "Attach",
		request = "attach",
		pid = require("dap.utils").pick_process,
		program = "${workspaceFolder}",
		dlvToolPath = vim.fn.exepath("dlv"),
	},
	{
		type = "go",
		name = "Debug curr file",
		request = "launch",
		program = "${file}",
		dlvToolPath = vim.fn.exepath("dlv"),
	},
	{
		type = "go",
		name = "Debug",
		request = "launch",
		program = "${workspaceFolder}",
		dlvToolPath = vim.fn.exepath("dlv"),
	},
	{
		type = "go",
		name = "Debug curr test",
		request = "launch",
		mode = "test",
		program = "${file}",
		dlvToolPath = vim.fn.exepath("dlv"),
	},
	{
		type = "go",
		name = "Debug test",
		request = "launch",
		mode = "test",
		program = "${workspaceFolder}",
		dlvToolPath = vim.fn.exepath("dlv"),
	},
}
vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
